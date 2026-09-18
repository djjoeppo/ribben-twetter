# Author: Jules Assistant
# Description: Fusion 360 Python API script to generate a 3D printable Chevron (Herringbone V-shape)
# Corrugator Gear for 10mm wide aluminum ribbon foil.
# Features:
# - Rounded Sinusoidal Tooth Profile (Pitch: 1.0mm, Depth: 0.6mm)
# - Chevron V-Pattern (Helical angle 30 degrees) via Loft Construction
# - Center shaft bore (5.0mm diameter) for M5 bolt or handle.
# - Explicit mm -> cm unit conversions and closed spline profiles.

import adsk.core, adsk.fusion, traceback
import math

def run(context):
    ui = None
    try:
        app = adsk.core.Application.get()
        ui  = app.userInterface

        doc = app.documents.add(adsk.core.DocumentTypes.FusionDesignDocumentType)
        design = app.activeProduct
        rootComp = design.rootComponent

        # Parameters for the Corrugator Gear (mm)
        num_teeth    = 36           # Number of teeth
        pitch_p      = 1.0          # Tooth pitch (1.0mm)
        tooth_depth  = 0.6          # Tooth depth (0.6mm)
        gear_width   = 15.0         # Face width (15mm for 10mm foil)
        helix_angle  = 30.0         # Chevron V-angle (30 deg)
        bore_d       = 5.0          # Center shaft diameter (5.0mm)

        # Convert mm to cm for Fusion 360 API internal unit system
        mm_to_cm = 0.1
        pitch_radius_cm = ((num_teeth * pitch_p) / (2.0 * math.pi)) * mm_to_cm # ~0.573 cm
        tooth_depth_cm  = tooth_depth * mm_to_cm                             # 0.06 cm
        bore_r_cm       = (bore_d / 2.0) * mm_to_cm                           # 0.25 cm
        gear_width_cm   = gear_width * mm_to_cm                               # 1.5 cm

        twist_rad = (gear_width_cm / 2.0) * math.tan(math.radians(helix_angle)) / pitch_radius_cm

        # Helper function to create sinusoidal tooth sketch at a given Z plane
        def create_gear_sketch(plane, rot_angle_rad):
            sk = rootComp.sketches.add(plane)
            pts = adsk.core.ObjectCollection.create()
            total_pts = num_teeth * 8

            for i in range(total_pts):
                a = (i / float(total_pts)) * 2.0 * math.pi
                r = pitch_radius_cm + (tooth_depth_cm / 2.0) * math.sin(num_teeth * a)
                x = r * math.cos(a + rot_angle_rad)
                y = r * math.sin(a + rot_angle_rad)
                pts.add(adsk.core.Point3D.create(x, y, 0))

            # Add first point at the end to ensure a closed spline loop
            pts.add(pts.item(0))
            spline = sk.fittedSplines.add(pts)
            spline.isClosed = True

            sk.sketchCurves.sketchCircles.addByCenterRadius(adsk.core.Point3D.create(0,0,0), bore_r_cm)

            # Select gear boundary profile (largest area profile)
            gear_profile = None
            max_area = -1.0
            for prof in sk.profiles:
                area = prof.areaProperties().area
                if area > max_area:
                    max_area = area
                    gear_profile = prof
            return gear_profile

        # Construction Plane 0 (Z = 0cm)
        xyPlane = rootComp.xYConstructionPlane
        prof0 = create_gear_sketch(xyPlane, 0.0)

        # Construction Plane 1 (Z = 0.75cm - Middle Chevron V)
        planes = rootComp.constructionPlanes
        planeInput1 = planes.createInput()
        planeInput1.setPositionByOffset(xyPlane, adsk.core.ValueInput.createByReal(gear_width_cm / 2.0))
        plane1 = planes.add(planeInput1)
        prof1 = create_gear_sketch(plane1, twist_rad)

        # Construction Plane 2 (Z = 1.5cm - Top Chevron V)
        planeInput2 = planes.createInput()
        planeInput2.setPositionByOffset(xyPlane, adsk.core.ValueInput.createByReal(gear_width_cm))
        plane2 = planes.add(planeInput2)
        prof2 = create_gear_sketch(plane2, 0.0)

        # Create Loft 1 (Bottom to Middle Chevron)
        lofts = rootComp.features.loftFeatures
        loftInput1 = lofts.createInput(adsk.fusion.FeatureOperations.NewBodyFeatureOperation)
        loftInput1.loftSections.add(prof0)
        loftInput1.loftSections.add(prof1)
        loft1 = lofts.add(loftInput1)

        # Create Loft 2 (Middle to Top Chevron)
        loftInput2 = lofts.createInput(adsk.fusion.FeatureOperations.JoinFeatureOperation)
        loftInput2.loftSections.add(prof1)
        loftInput2.loftSections.add(prof2)
        loft2 = lofts.add(loftInput2)

        ui.messageBox('Visgraat (Chevron) Corrugator Tandwiel succesvol gegeneerd in Fusion 360!\n' +
                      'Steek: 1.0mm | Tanddiepte: 0.6mm | Visgraathoek: 30 gr')

    except:
        if ui:
            ui.messageBox('Fout bij het uitvoeren van het script:\n{}'.format(traceback.format_exc()))
