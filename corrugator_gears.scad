// ==============================================================================
// OpenSCAD Parametric Chevron Corrugator Gear Generator
// Designed for 10mm wide Aluminum Foil Ribbon
// Features:
// - Sinusoidal rounded teeth (1.0mm pitch, 0.6mm depth)
// - Chevron (Herringbone V-shape) angle (30 deg)
// - Center shaft hole (5.0mm diameter) for M5 bolt or printable handle
// ==============================================================================

// --- PARAMETERS ---
num_teeth      = 36;      // Number of teeth
pitch          = 1.0;     // Tooth pitch in mm (1.0mm)
tooth_depth    = 0.6;     // Tooth depth in mm (0.6mm)
gear_width     = 15.0;    // Gear face width (15mm for 10mm foil)
helix_angle    = 30.0;    // Chevron angle (30 degrees)
bore_d         = 5.0;     // Center shaft hole diameter (5.0mm)

// --- DERIVED CALCULATIONS ---
pitch_r = (num_teeth * pitch) / (2 * PI);
twist_angle = (gear_width / 2) * tan(helix_angle) / pitch_r * (180 / PI);

// --- MODULE DEFINITION ---
module chevron_gear_half(twist_dir=1) {
    linear_extrude(height = gear_width/2, twist = twist_dir * twist_angle, slices = 30) {
        difference() {
            // Sinusoidal rounded tooth profile
            polygon(points = [ for (i = [0 : 360])
                let (r = pitch_r + (tooth_depth/2) * sin(num_teeth * i))
                [r * cos(i), r * sin(i)]
            ]);

            // Center bore
            circle(d = bore_d, $fn = 32);
        }
    }
}

module full_chevron_corrugator_gear() {
    union() {
        // Lower half of Chevron V
        translate([0, 0, 0])
            chevron_gear_half(twist_dir = 1);

        // Upper half of Chevron V (mirrored twist)
        translate([0, 0, gear_width/2])
            rotate([0, 0, twist_angle])
                chevron_gear_half(twist_dir = -1);
    }
}

// --- RENDER PAIR OF MESSED CORRUGATOR GEARS ---
// Gear 1
full_chevron_corrugator_gear();

// Gear 2 (Mashed next to gear 1)
translate([2 * pitch_r, 0, 0])
    rotate([0, 0, 180 / num_teeth])
        full_chevron_corrugator_gear();
