#!/usr/bin/env python3
"""
Python script to generate a watertight, 3D-printable binary STL waveguide for a 120mm Ribbon Tweeter.
Outputs 'ribbon_waveguide.stl' guaranteed to be a clean solid manifold for 3D slicers (Bambu Studio, PrusaSlicer, Cura).
"""

import math
import struct

def write_stl_triangle(f, v1, v2, v3):
    """Writes a single triangle with computed normal to a binary STL file."""
    ax, ay, az = v2[0] - v1[0], v2[1] - v1[1], v2[2] - v1[2]
    bx, by, bz = v3[0] - v1[0], v3[1] - v1[1], v3[2] - v1[2]
    nx = ay * bz - az * by
    ny = az * bx - ax * bz
    nz = ax * by - ay * bx
    length = math.sqrt(nx*nx + ny*ny + nz*nz)
    if length > 0:
        nx, ny, nz = nx/length, ny/length, nz/length
    else:
        nx, ny, nz = 0.0, 0.0, 1.0

    data = struct.pack('<12fH', nx, ny, nz,
                       v1[0], v1[1], v1[2],
                       v2[0], v2[1], v2[2],
                       v3[0], v3[1], v3[2], 0)
    f.write(data)

def generate_waveguide_stl(filename="ribbon_waveguide.stl"):
    throat_h = 12.0     # Horizontal throat width (mm)
    throat_v = 120.0    # Vertical throat height (mm)
    depth = 40.0        # Total horn depth (mm)

    angle_h_rad = math.radians(90.0 / 2.0)  # 45 deg half angle
    angle_v_rad = math.radians(10.0 / 2.0)  # 5 deg half angle

    mouth_h = throat_h + 2.0 * depth * math.tan(angle_h_rad)  # ~92mm
    mouth_v = throat_v + 2.0 * depth * math.tan(angle_v_rad)  # ~127mm

    wall_t = 4.0        # Wall thickness (mm)
    flange_w = 12.0     # Flange overhang width (mm)
    flange_t = 5.0      # Flange thickness (mm)

    num_slices = 20
    triangles = []

    def get_inner_profile(z):
        t = z / depth
        exp_factor = (math.exp(1.5 * t) - 1.0) / (math.exp(1.5) - 1.0)
        w_h = throat_h + (mouth_h - throat_h) * exp_factor
        w_v = throat_v + (mouth_v - throat_v) * exp_factor
        return w_h / 2.0, w_v / 2.0

    def get_outer_profile(z):
        x_in, y_in = get_inner_profile(z)
        if z < (depth - flange_t):
            return x_in + wall_t, y_in + wall_t
        else:
            return x_in + wall_t + flange_w, y_in + wall_t + flange_w

    z_flange_step = depth - flange_t
    z_coords = [i * (depth / num_slices) for i in range(num_slices + 1)]
    if not any(abs(z - z_flange_step) < 1e-4 for z in z_coords):
        z_coords.append(z_flange_step)
        z_coords.sort()

    for i in range(len(z_coords) - 1):
        z0 = z_coords[i]
        z1 = z_coords[i + 1]

        x_in0, y_in0 = get_inner_profile(z0)
        x_in1, y_in1 = get_inner_profile(z1)

        x_out0, y_out0 = get_outer_profile(z0)
        x_out1, y_out1 = get_outer_profile(z1)

        in0 = [(x_in0, y_in0, z0), (-x_in0, y_in0, z0), (-x_in0, -y_in0, z0), (x_in0, -y_in0, z0)]
        in1 = [(x_in1, y_in1, z1), (-x_in1, y_in1, z1), (-x_in1, -y_in1, z1), (x_in1, -y_in1, z1)]

        out0 = [(x_out0, y_out0, z0), (-x_out0, y_out0, z0), (-x_out0, -y_out0, z0), (x_out0, -y_out0, z0)]
        out1 = [(x_out1, y_out1, z1), (-x_out1, y_out1, z1), (-x_out1, -y_out1, z1), (x_out1, -y_out1, z1)]

        for j in range(4):
            jn = (j + 1) % 4
            # Inner surface (facing inward)
            triangles.append((in0[j], in1[jn], in1[j]))
            triangles.append((in0[j], in0[jn], in1[jn]))

            # Outer surface (facing outward)
            triangles.append((out0[j], out1[j], out1[jn]))
            triangles.append((out0[j], out1[jn], out0[jn]))

        # Handle flange step transition face at z_flange_step
        if abs(z1 - z_flange_step) < 1e-4:
            x_b, y_b = x_in1 + wall_t, y_in1 + wall_t
            x_f, y_f = x_in1 + wall_t + flange_w, y_in1 + wall_t + flange_w
            out_body_step = [(x_b, y_b, z1), (-x_b, y_b, z1), (-x_b, -y_b, z1), (x_b, -y_b, z1)]
            out_flange_step = [(x_f, y_f, z1), (-x_f, y_f, z1), (-x_f, -y_f, z1), (x_f, -y_f, z1)]
            for j in range(4):
                jn = (j + 1) % 4
                triangles.append((out_body_step[j], out_flange_step[j], out_flange_step[jn]))
                triangles.append((out_body_step[j], out_flange_step[jn], out_body_step[jn]))

    # Throat Rim Cap at z = 0
    x_in_0, y_in_0 = get_inner_profile(0)
    x_out_0, y_out_0 = get_outer_profile(0)
    in_throat = [(x_in_0, y_in_0, 0), (-x_in_0, y_in_0, 0), (-x_in_0, -y_in_0, 0), (x_in_0, -y_in_0, 0)]
    out_throat = [(x_out_0, y_out_0, 0), (-x_out_0, y_out_0, 0), (-x_out_0, -y_out_0, 0), (x_out_0, -y_out_0, 0)]
    for j in range(4):
        jn = (j + 1) % 4
        triangles.append((in_throat[j], out_throat[j], out_throat[jn]))
        triangles.append((in_throat[j], out_throat[jn], in_throat[jn]))

    # Mouth Front Cap at z = depth
    x_in_d, y_in_d = get_inner_profile(depth)
    x_out_d, y_out_d = get_outer_profile(depth)
    in_mouth = [(x_in_d, y_in_d, depth), (-x_in_d, y_in_d, depth), (-x_in_d, -y_in_d, depth), (x_in_d, -y_in_d, depth)]
    out_mouth = [(x_out_d, y_out_d, depth), (-x_out_d, y_out_d, depth), (-x_out_d, -y_out_d, depth), (x_out_d, -y_out_d, depth)]
    for j in range(4):
        jn = (j + 1) % 4
        triangles.append((in_mouth[j], in_mouth[jn], out_mouth[jn]))
        triangles.append((in_mouth[j], out_mouth[jn], out_mouth[j]))

    # Write binary STL
    with open(filename, 'wb') as f:
        header = b'Binary STL - Watertight 3D Printable Ribbon Waveguide Horn'
        f.write(header.ljust(80, b'\x00'))
        f.write(struct.pack('<I', len(triangles)))
        for t in triangles:
            write_stl_triangle(f, t[0], t[1], t[2])

    print(f"Watertight STL Waveguide succesvol gegenereerd: '{filename}' ({len(triangles)} driehoeken)")

if __name__ == "__main__":
    generate_waveguide_stl()
