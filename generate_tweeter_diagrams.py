import matplotlib.pyplot as plt
import numpy as np
import matplotlib.patches as patches

# Set up figure with 3 subplots for complete schematic design
fig, (ax1, ax2, ax3) = plt.subplots(1, 3, figsize=(18, 6.5), dpi=300)
fig.patch.set_facecolor('#f8f9fa')

# Colors
MAGNET_N = '#dc2626'   # Red for North
MAGNET_S = '#2563eb'   # Blue for South
YOKE_COLOR = '#94a3b8'  # Steel gray
TPU_COLOR = '#16a34a'   # Green TPU
TEXT_COLOR = '#0f172a'

# ----------------------------------------------------
# Diagram 1: Magnet Motor Cross Section (Top-down View)
# ----------------------------------------------------
ax1.set_aspect('equal')
ax1.axis('off')
ax1.set_title("1. Magnetisch Motor Ontwerp (Top-Down)", fontsize=12, fontweight='bold', pad=15, color=TEXT_COLOR)

# Left Magnets (Stack 2x N52: North facing Gap)
mag_left = patches.Rectangle((-10, -5), 5, 10, fc=MAGNET_N, ec='#991b1b', lw=1.5)
ax1.add_patch(mag_left)
ax1.text(-7.5, 0, "N", color='white', fontweight='bold', fontsize=14, ha='center', va='center')
ax1.text(-12.5, 0, "2x N52\n(Stack)", fontsize=8, ha='center', va='center', color=TEXT_COLOR)

# Right Magnets (Stack 2x N52: South facing Gap)
mag_right = patches.Rectangle((5, -5), 5, 10, fc=MAGNET_S, ec='#1e40af', lw=1.5)
ax1.add_patch(mag_right)
ax1.text(7.5, 0, "S", color='white', fontweight='bold', fontsize=14, ha='center', va='center')
ax1.text(12.5, 0, "2x N52\n(Stack)", fontsize=8, ha='center', va='center', color=TEXT_COLOR)

# Magnetic Gap & Ribbon
gap = patches.Rectangle((-5, -5), 10, 10, fc='#f1f5f9', ec='#cbd5e1', ls='--')
ax1.add_patch(gap)

# Magnetic Field Lines (Left N to Right S)
for y_pos in np.linspace(-3.5, 3.5, 5):
    ax1.annotate("", xy=(4.8, y_pos), xytext=(-4.8, y_pos),
                 arrowprops=dict(arrowstyle="->", color='#334155', lw=1.2, ls=':'))

# Ribbon in center
ribbon1 = patches.Rectangle((-0.4, -4.5), 0.8, 9, fc='#475569', ec='#0f172a', lw=1.5)
ax1.add_patch(ribbon1)
ax1.text(0, 5.8, "Alu Lint (10mm x 12µm)", fontsize=8.5, ha='center', va='bottom', fontweight='bold', color=TEXT_COLOR)

# Steel Yoke (Optional Upgrade)
yoke_back = patches.Rectangle((-11, -8.0), 22, 2.0, fc=YOKE_COLOR, ec='#334155', hatch='//')
ax1.add_patch(yoke_back)
ax1.text(0, -7.0, "Optionele Stalen Yoke (+6dB SPL)", fontsize=8.5, ha='center', va='center', color='#0f172a', fontweight='bold')

ax1.set_xlim(-16, 16)
ax1.set_ylim(-10, 8)

# ----------------------------------------------------
# Diagram 2: Ribbon Corrugation & TPU Clamp Assembly
# ----------------------------------------------------
ax2.set_aspect('equal')
ax2.axis('off')
ax2.set_title("2. Lint Corrugatie & TPU Klemconstructie", fontsize=12, fontweight='bold', pad=15, color=TEXT_COLOR)

# Corrugated Ribbon Line
x_corrug = np.linspace(-4, 4, 200)
y_corrug = 0.3 * np.sin(x_corrug * 8)
ax2.plot(x_corrug, y_corrug, color='#334155', lw=2.5, zorder=4)

# Top TPU Clamp
tpu_top = patches.Rectangle((-5.5, 0.5), 2.5, 2, fc=TPU_COLOR, ec='#15803d', lw=1.5)
ax2.add_patch(tpu_top)
ax2.text(-4.25, 1.5, "TPU\nKlem", color='white', fontweight='bold', fontsize=8, ha='center', va='center')

# Bottom Copper Contact
copper_bot = patches.Rectangle((-5.5, -2.5), 2.5, 2, fc='#b45309', ec='#78350f', lw=1.5)
ax2.add_patch(copper_bot)
ax2.text(-4.25, -1.5, "Koper\nTape", color='white', fontweight='bold', fontsize=8, ha='center', va='center')

# Right Clamp
tpu_top_r = patches.Rectangle((3.0, 0.5), 2.5, 2, fc=TPU_COLOR, ec='#15803d', lw=1.5)
copper_bot_r = patches.Rectangle((3.0, -2.5), 2.5, 2, fc='#b45309', ec='#78350f', lw=1.5)
ax2.add_patch(tpu_top_r)
ax2.add_patch(copper_bot_r)

# Annotations
ax2.annotate("Fijne Corrugation\n(Pitch 1.0mm, Diepte 0.4mm)\nVoorkomt 'wapperen'",
            xy=(0, 0.3), xytext=(0, 3.2),
            arrowprops=dict(arrowstyle="->", color='#334155', lw=1.5),
            fontsize=8.5, ha='center', bbox=dict(boxstyle="round,pad=0.4", fc="white", ec="#94a3b8"))

ax2.set_xlim(-7, 7)
ax2.set_ylim(-4, 5)

# ----------------------------------------------------
# Diagram 3: PA Line Array Waveguide Profile
# ----------------------------------------------------
ax3.set_aspect('equal')
ax3.axis('off')
ax3.set_title("3. PA Line Array Waveguide / Hoorn", fontsize=12, fontweight='bold', pad=15, color=TEXT_COLOR)

# Waveguide Horn Profile
horn_top_x = [0, 1.5, 6, 8]
horn_top_y = [1.0, 1.2, 3.5, 4.5]

horn_bot_x = [0, 1.5, 6, 8]
horn_bot_y = [-1.0, -1.2, -3.5, -4.5]

ax3.plot(horn_top_x, horn_top_y, color='#0f172a', lw=3)
ax3.plot(horn_bot_x, horn_bot_y, color='#0f172a', lw=3)

# Fill 3D-printed body
ax3.fill_between(horn_top_x, horn_top_y, [y + 1.5 for y in horn_top_y], color='#cbd5e1', hatch='\\\\')
ax3.fill_between(horn_bot_x, horn_bot_y, [y - 1.5 for y in horn_bot_y], color='#cbd5e1', hatch='\\\\')

# Acoustic Waves
for r in [2.5, 4.5, 6.5, 8.5]:
    arc = patches.Arc((0, 0), r*1.2, r*0.8, angle=0, theta1=-25, theta2=25, color='#0284c7', lw=1.8, ls='--')
    ax3.add_patch(arc)

ax3.text(-1.5, 0, "Ribbon\nSlot", fontweight='bold', fontsize=8.5, ha='center', va='center')
ax3.text(4.5, 0, "Cylindrische Golf\n(High Outdoor Throw)", color='#0284c7', fontweight='bold', fontsize=8.5, ha='center', va='center')

ax3.set_xlim(-3, 10)
ax3.set_ylim(-6, 6)

plt.tight_layout()
plt.savefig("schematisch_ribbon_tweeter_ontwerp.png", dpi=300, bbox_inches='tight')
print("Diagrammen succesvol gegenereerd: schematisch_ribbon_tweeter_ontwerp.png")
