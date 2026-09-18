// ==============================================================================
// OpenSCAD Parametric Ribbon Tweeter Driver - Ultimate Production Version
// Features:
// 1. ZIJ-INLOOP MAGNEETSLEUVEN MET M3 BORGBOUTGATEN: Magneten schuiven van de
//    zijkant naar binnen en worden geborgd met M3 schroefjes zodat ze er nooit
//    uit kunnen trillen.
// 2. DIEPE KERN-CENTRERING (Z = 10mm): Lint rust exact op Z = 10mm in het spleetmidden.
// 3. MIDDENBRUG MET TPU DEMPINGSKLEM: Vrije akoestische doorgang met ondersteuning bij Y=0.
// 4. KOPER TAPE & KABEL-GLEUVEN: Uitsparingen voor soldeerdraden naar de trafo.
// 5. GEÏNTEGREERDE TRAFO/CONDENSATOR BEVESTIGINGS-OREN: M4 montagelijnen aan de
//    achterzijde van de behuizing voor het opschroeven van de trafo & 3.7uF condensator.
// 6. LOSSE TPU DEMPINGSPAKKINGEN: 3D-geprinte TPU sluitstrips tegen inscheuren.
// ==============================================================================

// --- PARAMETERS (All dimensions in mm) ---
mag_length      = 60.0;     // Lengte van N52 magneet (60mm along Y)
mag_height      = 10.0;     // Hoogte van N52 magneet (10mm along Z: van Z=5 tot Z=15)
mag_thick       = 5.0;      // Dikte van N52 magneet (5mm along X)
num_mags_stack  = 2;        // 2 magneten gestapeld per pool = 10mm dikte in X

ribbon_length   = 120.0;    // Actieve lintlengte (2x 60mm magneetspan)
gap_width       = 12.0;     // Luchtspleet breedte (10mm lint + 1mm marge aan elke kant)
inner_wall_t    = 1.0;      // Binnenwand dikte die magneten op exact 12mm afstand houdt

body_width      = 54.0;     // Totale breedte behuizing (X)
body_height     = 180.0;    // Totale hoogte behuizing (Y)
body_depth      = 20.0;     // Totale diepte behuizing (Z)

front_flange_w  = 10.0;     // Flens overhang voor waveguide
front_flange_t  = 5.0;      // Flens dikte

total_mag_thick = mag_thick * num_mags_stack; // 10.0mm dikte per pool
ribbon_z        = body_depth / 2.0;            // Ribbon plane exact centered at Z = 10.0mm

// --- MODULE 1: HOOFDBEHIUZING (DRIVER BODY) ---
module ribbon_tweeter_driver_body() {
    difference() {
        // A. Massief hoofdblok met voorste keelflens en achterste montagelabben
        union() {
            // Hoofdblok
            translate([0, 0, body_depth/2])
                cube([body_width, body_height, body_depth], center=true);

            // Voorste keelflens voor waveguide
            translate([0, 0, body_depth - front_flange_t/2])
                cube([gap_width + 8.0 + 2*front_flange_w,
                      ribbon_length + 8.0 + 2*front_flange_w,
                      front_flange_t], center=true);

            // Achterste montagelabben voor Trafo & 3.7uF Condensator (aan de zijkanten)
            for (sy = [-1, 1]) {
                translate([0, sy * (body_height/2 + 8), body_depth/2])
                    cube([body_width, 16, body_depth], center=true);
            }
        }

        // B. OPEN LUCHTSPLEET (Met solide middenbrug bij Y=0 op Z=10mm)
        for (sy = [-1, 1]) {
            translate([0, sy * (ribbon_length/4 + 2), body_depth/2])
                cube([gap_width, ribbon_length/2 - 4, body_depth + 4], center=true);
        }

        // C. ZIJ-INLOOP MAGNEETSLEUVEN MET BORGGATEN
        for (sy = [-1, 1]) {
            // Links magneetsleuf
            translate([-(gap_width/2 + inner_wall_t + total_mag_thick/2), sy * (mag_length/2 + 2), ribbon_z])
                cube([total_mag_thick + 0.3, mag_length + 0.4, mag_height + 0.3], center=true);

            // Rechts magneetsleuf
            translate([(gap_width/2 + inner_wall_t + total_mag_thick/2), sy * (mag_length/2 + 2), ribbon_z])
                cube([total_mag_thick + 0.3, mag_length + 0.4, mag_height + 0.3], center=true);

            // Invoersleuven vanaf de zijkant
            translate([-(body_width/2 + gap_width/2 + inner_wall_t)/2, sy * (mag_length/2 + 2), ribbon_z])
                cube([body_width/2 - (gap_width/2 + inner_wall_t) + 0.1, mag_length + 0.4, mag_height + 0.3], center=true);

            translate([(body_width/2 + gap_width/2 + inner_wall_t)/2, sy * (mag_length/2 + 2), ribbon_z])
                cube([body_width/2 - (gap_width/2 + inner_wall_t) + 0.1, mag_length + 0.4, mag_height + 0.3], center=true);
        }

        // Magneet Borgschroefgaten (M3 borging aan het einde van de sleuf)
        for (sy = [-1, 1]) {
            for (sx = [-1, 1]) {
                translate([sx * (body_width/2 - 3), sy * (mag_length/2 + 2), 0])
                    cylinder(d=3.0, h=body_depth + 2, $fn=32);
            }
        }

        // D. KOPSE LINTKLEM ZITTINGEN & KABELGOOTJES
        for (sy = [-1, 1]) {
            translate([0, sy * (ribbon_length/2 + 12.5), ribbon_z + body_depth/4])
                cube([gap_width + 20, 22, body_depth/2 + 0.1], center=true);

            // Kabel-uitgangsgootjes voor trafo-draden naar achteren
            translate([0, sy * (ribbon_length/2 + 22), ribbon_z])
                cube([8.0, 10, 6.0], center=true);
        }

        // E. MIDDENKLEM ZITTING
        translate([0, 0, ribbon_z + body_depth/4])
            cube([gap_width + 8, 6, body_depth/2 + 0.1], center=true);

        // F. SCHROEFGATEN VOOR KOPSE KLEMMEN (4x M3 per klem)
        for (sy = [-1, 1]) {
            for (sx = [-1, 1]) {
                for (sy_inner = [-1, 1]) {
                    translate([sx * (gap_width/2 + 6), sy * (ribbon_length/2 + 12.5) + sy_inner * 6, 0])
                        cylinder(d=3.5, h=body_depth + 2, $fn=32);
                }
            }
        }

        // G. SCHROEFGATEN VOOR MIDDENKLEM (2x M3)
        for (sx = [-1, 1]) {
            translate([sx * (gap_width/2 + 3.5), 0, 0])
                cylinder(d=3.5, h=body_depth + 2, $fn=32);
        }

        // H. WAVEGUIDE MONTAGEGATEN (6x M3 hitte-insmeltgaten op de voorflens)
        t_hx = (gap_width / 2) + 4.0 + (front_flange_w / 2);
        t_hy = (ribbon_length / 2) + 4.0 + (front_flange_w / 2);

        for (sx = [-1, 1]) {
            for (sy = [-1, 1]) {
                translate([sx * t_hx, sy * t_hy, body_depth - 10])
                    cylinder(d=4.2, h=12, $fn=32);
            }
        }
        for (sy = [-1, 1]) {
            translate([0, sy * t_hy, body_depth - 10])
                cylinder(d=4.2, h=12, $fn=32);
        }

        // I. MONTAGEGATEN VOOR TRAFO & CONDENSATOR (4x M4 op de achterste montagelabben)
        for (sx = [-1, 1]) {
            for (sy = [-1, 1]) {
                translate([sx * (body_width/2 - 8), sy * (body_height/2 + 8), 0])
                    cylinder(d=4.5, h=body_depth + 2, $fn=32);
            }
        }
    }
}

// --- MODULE 2: ROBUUSTE KOPSE LINTKLEM STRIP (PETG/ABS) ---
module large_end_clamp() {
    difference() {
        cube([gap_width + 20, 22, 4], center=true);
        for (sx = [-1, 1]) {
            for (sy = [-1, 1]) {
                translate([sx * (gap_width/2 + 6), sy * 6, 0])
                    cylinder(d=3.5, h=6, center=true, $fn=32);
            }
        }
    }
}

// --- MODULE 3: TPU FLEXIBELE DEMPINGSPAKKING (Tussen Lint & Klem) ---
module tpu_flex_gasket() {
    difference() {
        cube([gap_width + 20, 22, 1.2], center=true);
        for (sx = [-1, 1]) {
            for (sy = [-1, 1]) {
                translate([sx * (gap_width/2 + 6), sy * 6, 0])
                    cylinder(d=3.5, h=3, center=true, $fn=32);
            }
        }
        // Vrije geluidsopening in het midden van de pakking
        cube([gap_width, 18, 3], center=true);
    }
}

// --- MODULE 4: ULTRA-COMPACTE MIDDENKLEM STRIP (TPU) ---
module compact_center_clamp() {
    difference() {
        cube([gap_width + 8, 5, 3], center=true);
        for (sx = [-1, 1]) {
            translate([sx * (gap_width/2 + 3.5), 0, 0])
                cylinder(d=3.5, h=5, center=true, $fn=32);
        }
    }
}

// --- RENDER DRIVER ASSEMBLY ---
ribbon_tweeter_driver_body();

// Losse onderdelen ter illustratie naast de behuizing getekend
translate([body_width/2 + 30, 50, 2.0]) large_end_clamp();
translate([body_width/2 + 30, 25, 0.6]) tpu_flex_gasket();
translate([body_width/2 + 30, 0, 1.5]) compact_center_clamp();
translate([body_width/2 + 30, -25, 0.6]) tpu_flex_gasket();
translate([body_width/2 + 30, -50, 2.0]) large_end_clamp();
