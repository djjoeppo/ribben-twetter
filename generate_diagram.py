import matplotlib.pyplot as plt
import numpy as np
import matplotlib.patches as patches

# Set up figure and axis
fig, ax = plt.subplots(figsize=(10, 10), dpi=300)
ax.set_aspect('equal')
ax.axis('off')
fig.patch.set_facecolor('#f8f9fa')

# Colors
CORE_COLOR = '#2b2b2b'
PRIMARY_COLOR = '#d97706'  # Amber / Copper
SECONDARY_COLOR1 = '#2563eb' # Blue (Sec wire 1)
SECONDARY_COLOR2 = '#0284c7' # Light Blue (Sec wire 2)
TAPE_COLOR = '#facc15'    # Yellow Kapton tape
TEXT_COLOR = '#1e293b'

# Draw Toroid Core (FT240-43)
r_out = 3.5
r_in = 2.1
r_mid = (r_out + r_in) / 2
thickness = (r_out - r_in)

# Core Ring
outer_circle = patches.Circle((0, 0), r_out, color=CORE_COLOR, zorder=1)
inner_circle = patches.Circle((0, 0), r_in, color='#f8f9fa', zorder=2)
ax.add_patch(outer_circle)
ax.add_patch(inner_circle)

# Kapton tape layer indication (dashed circle around core)
tape_circle = patches.Circle((0, 0), r_out + 0.08, color='none', ec=TAPE_COLOR, lw=2.5, ls='--', zorder=3)
ax.add_patch(tape_circle)

# Draw Primary Windings (29 turns around the toroid)
n_primary = 29
angles_p = np.linspace(0, 2*np.pi, n_primary, endpoint=False) + 0.1

for idx, angle in enumerate(angles_p):
    # Calculate inner and outer points for each turn
    x_in = r_in * np.cos(angle)
    y_in = r_in * np.sin(angle)
    x_out = r_out * np.cos(angle)
    y_out = r_out * np.sin(angle)

    # Draw primary turn loop
    ax.plot([x_in, x_out], [y_in, y_out], color=PRIMARY_COLOR, lw=2.2, zorder=4, solid_capstyle='round')

    # Dots at edges for 3D/realistic turn effect
    ax.scatter(x_in, y_in, color='#b45309', s=15, zorder=5)
    ax.scatter(x_out, y_out, color='#b45309', s=15, zorder=5)

# Draw Secondary Windings (2 turns, bifilar 2x1.5mm)
# Place them at top (90 deg) and bottom (270 deg) over the primary
sec_angles = [np.pi/2 - 0.25, np.pi/2 + 0.25, -np.pi/2 - 0.25, -np.pi/2 + 0.25]

# Secondary Turn 1 (Top)
angle1 = np.pi/2 - 0.15
angle2 = np.pi/2 + 0.15

for angle, color in zip([angle1, angle2], [SECONDARY_COLOR1, SECONDARY_COLOR2]):
    x_in = (r_in - 0.1) * np.cos(angle)
    y_in = (r_in - 0.1) * np.sin(angle)
    x_out = (r_out + 0.2) * np.cos(angle)
    y_out = (r_out + 0.2) * np.sin(angle)
    ax.plot([x_in, x_out], [y_in, y_out], color=color, lw=5.5, zorder=6, solid_capstyle='round')

# Secondary Turn 2 (Bottom)
angle3 = -np.pi/2 - 0.15
angle4 = -np.pi/2 + 0.15

for angle, color in zip([angle3, angle4], [SECONDARY_COLOR1, SECONDARY_COLOR2]):
    x_in = (r_in - 0.1) * np.cos(angle)
    y_in = (r_in - 0.1) * np.sin(angle)
    x_out = (r_out + 0.2) * np.cos(angle)
    y_out = (r_out + 0.2) * np.sin(angle)
    ax.plot([x_in, x_out], [y_in, y_out], color=color, lw=5.5, zorder=6, solid_capstyle='round')

# Connecting bridge between Turn 1 and Turn 2 for Secondary (bifilar loop)
arc_theta = np.linspace(-np.pi/2 + 0.15, np.pi/2 - 0.15, 30)
ax.plot((r_out + 0.2)*np.cos(arc_theta), (r_out + 0.2)*np.sin(arc_theta), color=SECONDARY_COLOR1, lw=4, ls=':', zorder=6)
ax.plot((r_out + 0.25)*np.cos(arc_theta), (r_out + 0.25)*np.sin(arc_theta), color=SECONDARY_COLOR2, lw=4, ls=':', zorder=6)

# Labels & Annotations
plt.title("Optimale Wikkelstructuur Ribbon Tweeter Transformator", fontsize=16, fontweight='bold', pad=25, color=TEXT_COLOR)

# Core Label
ax.text(0, 0, "FT240-43\nFerrietkern\n(61 x 35.5 x 12.7 mm)", ha='center', va='center', fontsize=11, fontweight='bold', color=TEXT_COLOR)

# Primary Annotation
ax.annotate("Primaire Wikkeling (Np = 29)\n• 0.5 mm Geëmailleerd koper\n• Gelijkmatig verdeeld over 360°\n• Aansluiting naar versterker (4 Ω)",
            xy=(-2.5, 2.3), xytext=(-5.8, 4.0),
            arrowprops=dict(arrowstyle="->", color=PRIMARY_COLOR, lw=2),
            fontsize=10, bbox=dict(boxstyle="round,pad=0.5", fc="white", ec=PRIMARY_COLOR, lw=1.5),
            color=TEXT_COLOR)

# Secondary Annotation
ax.annotate("Secundaire Wikkeling (Ns = 2)\n• 2x 1.5 mm Parallel (Bifilair)\n• Strak over de primaire wikkeling\n• Kortste verbinding naar Ribbon Element",
            xy=(2.6, 2.4), xytext=(3.5, 4.0),
            arrowprops=dict(arrowstyle="->", color=SECONDARY_COLOR1, lw=2),
            fontsize=10, bbox=dict(boxstyle="round,pad=0.5", fc="white", ec=SECONDARY_COLOR1, lw=1.5),
            color=TEXT_COLOR)

# Tape Annotation
ax.annotate("Isolatielaag (Kapton / Teflon tape)\nTussen primair en secundair",
            xy=(-3.4, -0.8), xytext=(-5.8, -2.5),
            arrowprops=dict(arrowstyle="->", color='#ca8a04', lw=2),
            fontsize=10, bbox=dict(boxstyle="round,pad=0.5", fc="white", ec='#ca8a04', lw=1.5),
            color=TEXT_COLOR)

# Summary Info Box at bottom
info_text = (
    "  SAMENVATTING WIKKELPATROON:\n"
    "  1. Wikkel 29 strakke windingen (0.5mm) over de hele ringkern (Np = 29).\n"
    "  2. Breng een laag Kapton-tape aan ter isolatie.\n"
    "  3. Wikkel 2 secundaire windingen met 2 draden van 1.5mm parallel (bifilair, Ns = 2).\n"
    "  4. Verhouding 29:2 = 14.5:1 (Impedantie van 0.0185 Ω lint naar ~4 Ω primaire)."
)
ax.text(0, -4.8, info_text, ha='center', va='center', fontsize=10,
        bbox=dict(boxstyle="round,pad=0.6", fc="#e2e8f0", ec="#94a3b8", lw=1.5), color=TEXT_COLOR)

ax.set_xlim(-6.2, 6.2)
ax.set_ylim(-5.8, 5.2)

plt.tight_layout()
plt.savefig("wikkelpatroon_ribbon_trafo.png", dpi=300, bbox_inches='tight')
print("Diagram succesvol gegenereerd: wikkelpatroon_ribbon_trafo.png")
