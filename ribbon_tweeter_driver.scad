// ==============================================================================
// OpenSCAD Parametric Ribbon Tweeter Driver Assembly
// Designed for 120mm Active Ribbon (PA Outdoor Line Array)
// Features:
// - Frame housing for 4x N52 Neodymium magnets (60x10x5mm stacked 2-per-side)
// - 12mm Magnetic gap width x 120mm Active ribbon channel
// - Center TPU clamping block for dual-segment ribbon stability
// - Copper tape contact termination pads & M3 bolt mounting holes
// - Front flange mating face with 6x M3 holes matching ribbon_waveguide.scad
// ==============================================================================

// --- PARAMETERS (All dimensions in mm) ---
mag_length      = 60.0;     // Magnet length
mag_width       = 10.0;     // Magnet width
mag_thick       = 5.0;      // Magnet thickness
num_mags_stack  = 2;        // Stack 2 magnets per side for 10mm total depth

ribbon_length   = 120.0;    // Active ribbon length (2x 60mm magnet spans)
gap_width       = 12.0;     // Air gap width (10mm ribbon + 1mm clearance per side)

body_width      = 60.0;     // Overall driver body width
body_height     = 160.0;    // Overall driver body height (120mm ribbon + 20mm clamps top/bottom)
body_depth      = 25.0;     // Overall driver body depth

front_flange_w  = 10.0;     // Flange overhang matching waveguide throat flange
front_flange_t  = 5.0;      // Flange thickness

hole_d          = 3.5;      // M3 clearance hole diameter
insert_d        = 4.2;      // M3 heat-set insert hole diameter

// --- DERIVED CALCULATIONS ---
total_mag_depth = mag_thick * num_mags_stack; // 10mm

// --- MAIN ASSEMBLY MODULE ---
module ribbon_tweeter_driver() {
    difference() {
        // Main solid outer body with front waveguide mounting flange
        union() {
            // Main rectangular body
            translate([0, 0, body_depth/2])
                cube([body_width, body_height, body_depth], center=true);

            // Front mating flange (matching waveguide throat flange)
            translate([0, 0, body_depth - front_flange_t/2])
                cube([12.0 + 8.0 + 2*front_flange_w,
                      120.0 + 8.0 + 2*front_flange_w,
                      front_flange_t], center=true);
        }

        // 1. Central Sound Path Channel (through-hole for ribbon)
        translate([0, 0, body_depth/2])
            cube([gap_width, ribbon_length, body_depth + 2], center=true);

        // 2. Left Magnet Pocket (Holds 2x N52 magnets stacked: 60x10x10mm top & bottom)
        for (sy = [-1, 1]) {
            translate([-(gap_width/2 + total_mag_depth/2), sy * (mag_length/2 + 2), body_depth/2])
                cube([total_mag_depth + 0.2, mag_length + 0.4, mag_width + 0.2], center=true);
        }

        // 3. Right Magnet Pocket (Holds 2x N52 magnets stacked: 60x10x10mm top & bottom)
        for (sy = [-1, 1]) {
            translate([(gap_width/2 + total_mag_depth/2), sy * (mag_length/2 + 2), body_depth/2])
                cube([total_mag_depth + 0.2, mag_length + 0.4, mag_width + 0.2], center=true);
        }

        // 4. Top & Bottom Terminal Recesses (for Copper Tape & TPU Clamp Strips)
        for (sy = [-1, 1]) {
            translate([0, sy * (ribbon_length/2 + 10), body_depth - 3])
                cube([gap_width + 10, 16, 6], center=true);
        }

        // 5. Center Clamping Recess (for TPU middle clamp at 60mm mark)
        translate([0, 0, body_depth - 3])
            cube([gap_width + 6, 8, 6], center=true);

        // 6. Front Waveguide Mounting Holes (6x M3 heat-set insert holes)
        t_hx = (gap_width / 2) + 4.0 + (front_flange_w / 2);
        t_hy = (ribbon_length / 2) + 4.0 + (front_flange_w / 2);

        // Corners
        for (sx = [-1, 1]) {
            for (sy = [-1, 1]) {
                translate([sx * t_hx, sy * t_hy, body_depth - 12])
                    cylinder(d=insert_d, h=15, $fn=32);
            }
        }
        // Center sides
        for (sy = [-1, 1]) {
            translate([0, sy * t_hy, body_depth - 12])
                cylinder(d=insert_d, h=15, $fn=32);
        }

        // 7. Rear Enclosure Bolt Holes (4x M3 through-body holes)
        for (sx = [-1, 1]) {
            for (sy = [-1, 1]) {
                translate([sx * (body_width/2 - 6), sy * (body_height/2 - 8), -1])
                    cylinder(d=hole_d, h=body_depth + 2, $fn=32);
            }
        }
    }
}

// --- RENDER DRIVER BODY ---
ribbon_tweeter_driver();
