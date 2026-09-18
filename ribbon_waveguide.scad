// ==============================================================================
// OpenSCAD Parametric Waveguide (Horn) Generator
// Designed for 120mm Ribbon Tweeter (PA Outdoor Line Array)
// Dispersion: 90 degrees Horizontal x 10 degrees Vertical
// ==============================================================================

// --- PARAMETERS (All dimensions in mm) ---
throat_width   = 12.0;    // Horizontal throat width (matches magnet gap)
throat_height  = 120.0;   // Vertical throat height (matches ribbon length)
horn_depth     = 40.0;    // Horn depth along Z axis

angle_h        = 90.0;    // Horizontal dispersion angle (degrees)
angle_v        = 10.0;    // Vertical dispersion angle (degrees)

wall_thickness = 4.0;     // Shell wall thickness (for PETG-CF / ABS)
flange_width   = 12.0;    // Mounting flange overhang width
flange_thick   = 5.0;     // Mounting flange thickness

hole_diameter  = 3.5;     // Mounting hole size (M3 screws)
fn_quality     = 32;      // Mesh resolution ($fn)

// --- DERIVED CALCULATIONS ---
half_angle_h = angle_h / 2.0;
half_angle_v = angle_v / 2.0;

mouth_width  = throat_width  + 2.0 * horn_depth * tan(half_angle_h);
mouth_height = throat_height + 2.0 * horn_depth * tan(half_angle_v);

// --- MODULE DEFINITION ---
module ribbon_waveguide() {
    difference() {
        // Outer solid shape (body + flange)
        union() {
            // Main expanding horn body
            hull() {
                // Throat outer footprint at z = 0
                translate([0, 0, 0])
                    cube([throat_width + 2*wall_thickness, throat_height + 2*wall_thickness, 0.1], center=true);

                // Mouth outer footprint at z = horn_depth - flange_thick
                translate([0, 0, horn_depth - flange_thick])
                    cube([mouth_width + 2*wall_thickness, mouth_height + 2*wall_thickness, 0.1], center=true);
            }

            // Mounting flange at front mouth
            translate([0, 0, horn_depth - flange_thick/2])
                cube([mouth_width + 2*wall_thickness + 2*flange_width,
                      mouth_height + 2*wall_thickness + 2*flange_width,
                      flange_thick], center=true);
        }

        // Inner acoustic horn cutout (hollow expansion path)
        hull() {
            // Throat inner opening at z = -1 (extra length for clean boolean subtract)
            translate([0, 0, -1])
                cube([throat_width, throat_height, 0.1], center=true);

            // Mouth inner opening at z = horn_depth + 1
            translate([0, 0, horn_depth + 1])
                cube([mouth_width, mouth_height, 0.1], center=true);
        }

        // M3 Mounting holes in the flange (4 corners + 2 middle)
        hole_x = (mouth_width / 2) + wall_thickness + (flange_width / 2);
        hole_y = (mouth_height / 2) + wall_thickness + (flange_width / 2);

        // Corner mounting holes
        for (sx = [-1, 1]) {
            for (sy = [-1, 1]) {
                translate([sx * hole_x, sy * hole_y, horn_depth - flange_thick - 1])
                    cylinder(d=hole_diameter, h=flange_thick + 3, $fn=fn_quality);
            }
        }

        // Center-top and center-bottom mounting holes for long array
        for (sy = [-1, 1]) {
            translate([0, sy * hole_y, horn_depth - flange_thick - 1])
                cylinder(d=hole_diameter, h=flange_thick + 3, $fn=fn_quality);
        }
    }
}

// --- RENDER GEOMETRY ---
ribbon_waveguide();
