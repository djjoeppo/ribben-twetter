// ==============================================================================
// OpenSCAD Parametric Ribbon Tweeter Driver - V8 (Deep Ribbon Seating at Z=10mm)
// Features:
// 1. LINT LIGT DIEP IN HET SYSTEEM (Z = 10.0mm): De zittingen voor het lint zijn 10mm
//    DIEP ingesneden vanaf de voorkant (Z = 20mm tot Z = 10mm).
//    Het lint rust nu exact op Z = 10.0mm, PRECIES in de KERN van de N52 magneten (Z=5..15mm)!
// 2. KLEMSTRIPS VALLEN IN DE DIEPE KANALEN: De 4mm dikke klemmen klemmen het lint vast
//    op Z=10mm en steken slechts tot Z=14mm, zodat het lint en de klemmen diep verzonken
//    in de behuizing liggen.
// 3. ZIJ-INLOOP MAGNEETSLEUVEN: Magneten schuiven van de zijkant in (Z = 5mm..15mm).
// 4. OPEN ACHTERKANT: Akoestische doorgang onder de magneten (Z = 0mm..10mm).
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
body_height     = 170.0;    // Totale hoogte behuizing (Y)
body_depth      = 20.0;     // Totale diepte behuizing (Z)

front_flange_w  = 10.0;     // Flens overhang voor waveguide
front_flange_t  = 5.0;      // Flens dikte

total_mag_thick = mag_thick * num_mags_stack; // 10.0mm dikte per pool
ribbon_z        = body_depth / 2.0;            // Ribbon plane exact centered at Z = 10.0mm

// --- MODULE 1: HOOFDBEHIUZING (DRIVER BODY) ---
module ribbon_tweeter_driver_body() {
    difference() {
        // A. Massief hoofdblok met VOORSTE KEELFLENS (Z = 20mm)
        union() {
            // Hoofdblok
            translate([0, 0, body_depth/2])
                cube([body_width, body_height, body_depth], center=true);

            // VOORSTE FLENS VOOR WAVEGUIDE MONTAGE (op Z = 20mm)
            translate([0, 0, body_depth - front_flange_t/2])
                cube([gap_width + 8.0 + 2*front_flange_w,
                      ribbon_length + 8.0 + 2*front_flange_w,
                      front_flange_t], center=true);
        }

        // B. OPEN LUCHTSPLEET (Met solide middenbrug bij Y=0 op Z=10mm)
        for (sy = [-1, 1]) {
            translate([0, sy * (ribbon_length/4 + 2), body_depth/2])
                cube([gap_width, ribbon_length/2 - 4, body_depth + 4], center=true);
        }

        // C. ZIJ-INLOOP MAGNEETSLEUVEN (Gecentreerd op Z = 10mm, d.w.z. van Z=5mm tot Z=15mm)
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

        // D. DIEPE KOPSE KLEM-ZITTINGEN (10mm DIEP ingesneden vanaf Z=20mm tot Z=10mm)
        // Het lint rust nu EXACT op Z = 10mm (in het hart van de magneten!)
        for (sy = [-1, 1]) {
            translate([0, sy * (ribbon_length/2 + 12.5), ribbon_z + body_depth/4])
                cube([gap_width + 20, 22, body_depth/2 + 0.1], center=true);
        }

        // E. DIEPE MIDDENKLEM ZITTING (10mm DIEP ingesneden vanaf Z=20mm tot Z=10mm)
        translate([0, 0, ribbon_z + body_depth/4])
            cube([gap_width + 8, 6, body_depth/2 + 0.1], center=true);

        // F. SCHROEFGATEN VOOR KOPSE KLEMMEN (M3 schroefgaten door het solide onderplatform)
        for (sy = [-1, 1]) {
            for (sx = [-1, 1]) {
                for (sy_inner = [-1, 1]) {
                    translate([sx * (gap_width/2 + 6), sy * (ribbon_length/2 + 12.5) + sy_inner * 6, 0])
                        cylinder(d=3.5, h=body_depth + 2, $fn=32);
                }
            }
        }

        // G. SCHROEFGATEN VOOR MIDDENKLEM (2x M3 in het solide onderplatform)
        for (sx = [-1, 1]) {
            translate([sx * (gap_width/2 + 3.5), 0, 0])
                cylinder(d=3.5, h=body_depth + 2, $fn=32);
        }

        // H. VOORKANT: WAVEGUIDE MONTAGEGATEN (6x M3 hitte-insmeltgaten op Z = 20mm op de voorflens)
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
    }
}

// --- MODULE 2: ROBUUSTE KOPSE LINTKLEM STRIP (Valt 4mm diep in de schacht op Z=10mm) ---
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

// --- MODULE 3: ULTRA-COMPACTE MIDDENKLEM STRIP (Valt 3mm diep in de schacht op Z=10mm) ---
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

// Losse klemmen ter illustratie naast de behuizing getekend
translate([body_width/2 + 25, 40, 2.0]) large_end_clamp();
translate([body_width/2 + 25, 0, 1.5]) compact_center_clamp();
translate([body_width/2 + 25, -40, 2.0]) large_end_clamp();
