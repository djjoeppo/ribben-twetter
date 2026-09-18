// ==============================================================================
// OpenSCAD Parametric Waveguide (Horn) Generator - Multi-Profile
// Designed for 120mm Ribbon Tweeter (PA Outdoor Line Array)
// Features: Selectable profile ("exponential", "tractrix", "conical"),
// adjustable depth, throat mounting flange, mouth flange, M3 holes,
// and 100% support-free 3D printable design (printed throat-down).
// ==============================================================================

// --- PARAMETERS (All dimensions in mm) ---
throat_width   = 12.0;    // Horizontal throat width (matches magnet gap)
throat_height  = 120.0;   // Vertical throat height (matches ribbon length)
horn_depth     = 50.0;    // Horn depth along Z axis (50mm gives fuller acoustic expansion)

angle_h        = 90.0;    // Target horizontal dispersion angle (degrees)
angle_v        = 10.0;    // Target vertical dispersion angle (degrees)

flare_type     = "exponential"; // Options: "exponential", "tractrix", "conical"

wall_thickness = 4.0;     // Shell wall thickness (for PETG-CF / ABS)
throat_flange_w= 10.0;    // Throat mounting flange width
throat_flange_t= 5.0;     // Throat mounting flange thickness

mouth_flange_w = 12.0;    // Mouth mounting flange width
mouth_flange_t = 5.0;     // Mouth mounting flange thickness

hole_diameter  = 3.5;     // Mounting hole diameter for M3 bolts
num_slices     = 50;      // Curve smoothness slices

// --- DERIVED PROFILE CALCULATIONS ---
half_angle_h = angle_h / 2.0;
half_angle_v = angle_v / 2.0;

// Conical target dimensions at horn_depth
mouth_w_conical = throat_width  + 2.0 * horn_depth * tan(half_angle_h);
mouth_h_conical = throat_height + 2.0 * horn_depth * tan(half_angle_v);

// Exponential expansion coefficients
alpha_h = log(mouth_w_conical / throat_width) / horn_depth;
alpha_v = log(mouth_h_conical / throat_height) / horn_depth;

function get_inner_w(z) =
    (flare_type == "conical") ? (throat_width + 2.0 * z * tan(half_angle_h)) :
    (flare_type == "exponential") ? (throat_width * exp(alpha_h * z)) :
    // Tractrix / Hybrid smooth flare
    (throat_width + (mouth_w_conical - throat_width) * pow(z / horn_depth, 1.5));

function get_inner_h(z) =
    (flare_type == "conical") ? (throat_height + 2.0 * z * tan(half_angle_v)) :
    (flare_type == "exponential") ? (throat_height * exp(alpha_v * z)) :
    (throat_height + (mouth_h_conical - throat_height) * pow(z / horn_depth, 1.5));

// --- MODULE DEFINITION ---
module ribbon_curved_waveguide() {
    difference() {
        // Outer solid geometry
        union() {
            for (i = [0 : num_slices - 1]) {
                z0 = i * (horn_depth / num_slices);
                z1 = (i + 1) * (horn_depth / num_slices);

                w0 = get_inner_w(z0) + 2 * wall_thickness;
                h0 = get_inner_h(z0) + 2 * wall_thickness;

                w1 = get_inner_w(z1) + 2 * wall_thickness;
                h1 = get_inner_h(z1) + 2 * wall_thickness;

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

            // Mouth mounting flange at z = (horn_depth - mouth_flange_t) .. horn_depth
            w_mouth_out = get_inner_w(horn_depth) + 2*wall_thickness + 2*mouth_flange_w;
            h_mouth_out = get_inner_h(horn_depth) + 2*wall_thickness + 2*mouth_flange_w;
            translate([0, 0, horn_depth - mouth_flange_t / 2])
                cube([w_mouth_out, h_mouth_out, mouth_flange_t], center=true);
        }

        // Inner acoustic cutout
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

        // --- THROAT MOUNTING HOLES ---
        t_hx = (throat_width / 2) + wall_thickness + (throat_flange_w / 2);
        t_hy = (throat_height / 2) + wall_thickness + (throat_flange_w / 2);

        for (sx = [-1, 1]) {
            for (sy = [-1, 1]) {
                translate([sx * t_hx, sy * t_hy, -1])
                    cylinder(d=hole_diameter, h=throat_flange_t + 2, $fn=32);
            }
        }
        for (sy = [-1, 1]) {
            translate([0, sy * t_hy, -1])
                cylinder(d=hole_diameter, h=throat_flange_t + 2, $fn=32);
        }

        // --- MOUTH MOUNTING HOLES ---
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
    }
}

// --- RENDER GEOMETRY ---
ribbon_curved_waveguide();
