// ==============================================================================
// OpenSCAD Parametric Ribbon Tweeter Driver - V6 (Precision Magnet Pockets & Center Bridge)
// Features:
// 1. EXACT MAGNET POCKET DIMENSIONS:
//    Magneetsleuven van exact 10.3mm breed in X (voor 2x gestapelde 5mm N52 magneten).
//    Gepositioneerd van X=7.0mm tot X=17.3mm, rustend tegen de 1.0mm binnenwand.
// 2. KERN-CENTRERING (Z-AS):
//    De magneten beslaan Z = 5mm tot 15mm (10mm breed). Het lint rust op een zitting op
//    Z = 10mm, waardoor het lint PRECIES in het magnetisch hart (Z = 10mm) ligt!
// 3. MIDDENKLEM BRUG (CENTER BRIDGE):
//    In de luchtspleet bij Y = 0mm zit een solide plastic brug/vloer op Z = 10mm.
//    Hier rust het lint op en drukt de TPU middenklem de folie stevig vast.
// 4. OPEN ACHTERKANT: Vrije akoestische doorgang boven en onder de middenbrug.
// ==============================================================================

// --- PARAMETERS (All dimensions in mm) ---
mag_length      = 60.0;     // Lengte van N52 magneet (60mm along Y)
mag_height      = 10.0;     // Hoogte van N52 magneet (10mm along Z)
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
        // A. Massief hoofdblok met voorste keelflens
        union() {
            // Hoofdblok
            translate([0, 0, body_depth/2])
                cube([body_width, body_height, body_depth], center=true);

            // Voorste keelflens (passend op waveguide flens)
            translate([0, 0, body_depth - front_flange_t/2])
                cube([gap_width + 8.0 + 2*front_flange_w,
                      ribbon_length + 8.0 + 2*front_flange_w,
                      front_flange_t], center=true);
        }

        // B. OPEN LUCHTSPLEET (Gesplitst in 2 openingen van Y=-60 tot Y=-3 en Y=+3 tot Y=+60)
        // Hierdoor blijft er op Y=0 een solide brug staan op Z=10mm voor de middenklem!
        for (sy = [-1, 1]) {
            translate([0, sy * (ribbon_length/4 + 2), body_depth/2])
                cube([gap_width, ribbon_length/2 - 4, body_depth + 4], center=true);
        }

        // C. EXACT MAATVASTE ZIJ-INLOOP MAGNEETSLEUVEN
        // Magneten zijn 10mm dik in X, 60mm lang in Y, 10mm hoog in Z.
        // Magneten liggen van X = 7.0mm tot 17.3mm (strakke sleuf van 10.3mm breed).
        // Magneten liggen in Z exact van Z = 5mm tot Z = 15mm (gecentreerd op Z = 10mm).
        for (sy = [-1, 1]) {
            // Links magneetsleuf (X = -12.15mm center)
            translate([-(gap_width/2 + inner_wall_t + total_mag_thick/2), sy * (mag_length/2 + 2), ribbon_z])
                cube([total_mag_thick + 0.3, mag_length + 0.4, mag_height + 0.3], center=true);

            // Rechts magneetsleuf (X = +12.15mm center)
            translate([(gap_width/2 + inner_wall_t + total_mag_thick/2), sy * (mag_length/2 + 2), ribbon_z])
                cube([total_mag_thick + 0.3, mag_length + 0.4, mag_height + 0.3], center=true);

            // Invoersleuven vanaf het zijkantoppervlak tot aan het magneetvak
            translate([-(body_width/2 + gap_width/2 + inner_wall_t)/2, sy * (mag_length/2 + 2), ribbon_z])
                cube([body_width/2 - (gap_width/2 + inner_wall_t) + 0.1, mag_length + 0.4, mag_height + 0.3], center=true);

            translate([(body_width/2 + gap_width/2 + inner_wall_t)/2, sy * (mag_length/2 + 2), ribbon_z])
                cube([body_width/2 - (gap_width/2 + inner_wall_t) + 0.1, mag_length + 0.4, mag_height + 0.3], center=true);
        }

        // D. KOPSE KLEM-ZITTINGEN (Ondiepe uitsparing van 2.5mm diep op Z = 10mm)
        for (sy = [-1, 1]) {
            translate([0, sy * (ribbon_length/2 + 12.5), ribbon_z + 1.25])
                cube([gap_width + 20, 22, 2.5], center=true);
        }

        // E. MIDDENKLEM ZITTING (Ondiepe uitsparing van 2.5mm diep op Z = 10mm bovenop de middenbrug)
        translate([0, 0, ribbon_z + 1.25])
            cube([gap_width + 8, 6, 2.5], center=true);

        // F. SCHROEFGATEN VOOR ROBUUSTE KOPSE KLEMMEN (4x M3 per kopse klem)
        for (sy = [-1, 1]) {
            for (sx = [-1, 1]) {
                for (sy_inner = [-1, 1]) {
                    translate([sx * (gap_width/2 + 6), sy * (ribbon_length/2 + 12.5) + sy_inner * 6, 0])
                        cylinder(d=3.5, h=body_depth + 2, $fn=32);
                }
            }
        }

        // G. SCHROEFGATEN VOOR COMPACTE MIDDENKLEM (2x M3 in de middenbrug)
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
    }
}

// --- MODULE 2: ROBUUSTE KOPSE LINTKLEM STRIP (Boven & Onder) ---
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

// --- MODULE 3: ULTRA-COMPACTE MIDDENKLEM STRIP (TPU) ---
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
