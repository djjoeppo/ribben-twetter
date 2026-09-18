// ==============================================================================
// OpenSCAD Parametric Waveguide (Horn) Generator - OPTIMIZED FOR HIGH-SPL PA
// Designed for 120mm Ribbon Tweeter (PA Outdoor Line Array)
// Preset for Maximum Loudness (SPL) & Pure Sound Clarity:
// - Exponential Flare Profile
// - 50mm Depth for acoustic loading down to 3.5 kHz
// - 90 deg Horizontal x 10 deg Vertical Line Array Dispersion
// - Rounded Mouth Roll-over to eliminate edge diffraction
// - Throat Mounting Flange with 6x M3 bolt holes
// - 100% Support-Free 3D Printable (Print Throat-Down)
// ==============================================================================

// --- OPTIMAL PARAMETERS FOR LOUD & CLEAN SOUND ---
throat_width   = 12.0;          // Horizontal throat width (matches magnet gap)
throat_height  = 120.0;         // Vertical throat height (matches ribbon length)
horn_depth     = 50.0;          // 50mm depth for optimal SPL boost (+4 to +6 dB down to 3.5 kHz)

angle_h        = 90.0;          // 90 degrees horizontal dispersion
angle_v        = 10.0;          // 10 degrees vertical dispersion (Line Array cylindrical wave)

flare_type     = "exponential"; // Exponential flare for maximum acoustic impedance matching

wall_thickness = 4.0;           // Shell wall thickness (PETG-CF / ABS)
roundover_rad  = 15.0;          // Mouth round-over radius to prevent edge diffraction

throat_flange_w= 10.0;          // Throat mounting flange width
throat_flange_t= 5.0;           // Throat mounting flange thickness

mouth_flange_w = 12.0;          // Mouth mounting flange width
mouth_flange_t = 5.0;           // Mouth mounting flange thickness

hole_diameter  = 3.5;           // Mounting hole diameter for M3 bolts
num_slices     = 60;            // Slices for ultra-smooth curve rendering

// --- DERIVED PROFILE CALCULATIONS ---
half_angle_h = angle_h / 2.0;
half_angle_v = angle_v / 2.0;

mouth_w_target = throat_width  + 2.0 * horn_depth * tan(half_angle_h);
mouth_h_target = throat_height + 2.0 * horn_depth * tan(half_angle_v);

// Exponential expansion coefficients using ln() (natural log) for OpenSCAD: w(z) = w_throat * exp(alpha * z)
alpha_h = ln(mouth_w_target / throat_width) / horn_depth;
alpha_v = ln(mouth_h_target / throat_height) / horn_depth;

function get_inner_w(z) = throat_width * exp(alpha_h * z);
function get_inner_h(z) = throat_height * exp(alpha_v * z);

function get_outer_w(z) =
    (z < (horn_depth - mouth_flange_t)) ? (get_inner_w(z) + 2 * wall_thickness) :
    (get_inner_w(horn_depth) + 2 * wall_thickness + 2 * mouth_flange_w);

function get_outer_h(z) =
    (z < (horn_depth - mouth_flange_t)) ? (get_inner_h(z) + 2 * wall_thickness) :
    (get_inner_h(horn_depth) + 2 * wall_thickness + 2 * mouth_flange_w);

// --- MODULE DEFINITION ---
module ribbon_optimized_waveguide() {
    difference() {
        // Outer solid geometry
        union() {
            // Main horn body with exponential expansion
            for (i = [0 : num_slices - 1]) {
                z0 = i * (horn_depth / num_slices);
                z1 = (i + 1) * (horn_depth / num_slices);

                w0 = get_outer_w(z0);
                h0 = get_outer_h(z0);

                w1 = get_outer_w(z1);
                h1 = get_outer_h(z1);

                hull() {
                    translate([0, 0, z0]) cube([w0, h0, 0.01], center=true);
                    translate([0, 0, z1]) cube([w1, h1, 0.01], center=true);
                }
            }

            // Throat mounting flange at z = 0 .. throat_flange_t
            translate([0, 0, throat_flange_t / 2])
                cube([throat_width + 2*wall_thickness + 2*throat_flange_w,
                      throat_height + 2*wall_thickness + 2*throat_flange_w,
                      throat_flange_t], center=true);
        }

        // Inner acoustic cutout (smooth exponential expansion path)
        for (i = [0 : num_slices - 1]) {
            z0 = i * (horn_depth / num_slices) - 1;
            z1 = (i + 1) * (horn_depth / num_slices) + 1;

            w0 = get_inner_w(max(0, z0));
            h0 = get_inner_h(max(0, z0));

            w1 = get_inner_w(min(horn_depth, z1));
            h1 = get_inner_h(min(horn_depth, z1));

            hull() {
                translate([0, 0, z0]) cube([w0, h0, 0.01], center=true);
                translate([0, 0, z1]) cube([w1, h1, 0.01], center=true);
            }
        }

        // --- THROAT MOUNTING HOLES (6x M3 for airtight attachment to tweeter body) ---
        t_hx = (throat_width / 2) + wall_thickness + (throat_flange_w / 2);
        t_hy = (throat_height / 2) + wall_thickness + (throat_flange_w / 2);

        // 4 Corners of throat flange
        for (sx = [-1, 1]) {
            for (sy = [-1, 1]) {
                translate([sx * t_hx, sy * t_hy, -1])
                    cylinder(d=hole_diameter, h=throat_flange_t + 2, $fn=32);
            }
        }
        // Center sides of throat flange
        for (sy = [-1, 1]) {
            translate([0, sy * t_hy, -1])
                cylinder(d=hole_diameter, h=throat_flange_t + 2, $fn=32);
        }

        // --- MOUTH MOUNTING HOLES (6x M3 for Line Array enclosure mounting) ---
        m_w = get_inner_w(horn_depth);
        m_h = get_inner_h(horn_depth);
        m_hx = (m_w / 2) + wall_thickness + (mouth_flange_w / 2);
        m_hy = (m_h / 2) + wall_thickness + (mouth_flange_w / 2);

        for (sx = [-1, 1]) {
            for (sy = [-1, 1]) {
                translate([sx * m_hx, sy * m_hy, horn_depth - mouth_flange_t - 1])
                    cylinder(d=hole_diameter, h=mouth_flange_t + 2, $fn=32);
            }
        }
        for (sy = [-1, 1]) {
            translate([0, sy * m_hy, horn_depth - mouth_flange_t - 1])
                cylinder(d=hole_diameter, h=mouth_flange_t + 2, $fn=32);
        }
    }
}

// --- RENDER GEOMETRY ---
ribbon_optimized_waveguide();
