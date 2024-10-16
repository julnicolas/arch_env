""" Gets the local keyboard config from the keyboard.

Supported mappings are stored in a map, any other mapping
will be represented as '?' by this script."""

import subprocess
from typing import List


def current() -> str:
    """Returns a /-separated-list of currently active keyboard mappings.
    If more than one element is returned, it generally means there is
    a problem with the system config."""

    # List all active layouts
    # Outputs:
    # xkb_active_layout_name: French, xkb_active_layout_name: english (us),...
    cmd = "swaymsg -t get_inputs | grep 'xkb_active_layout_name' | xargs"

    # Run the subcommand in a shell
    r = subprocess.run(cmd, shell=True, capture_output=True, timeout=2)
    if r.returncode != 0:
        return "!"

    # Several layouts can be enabled at the same time but it shouldn't be
    # the case generally
    active_layouts = set()
    for layout in [s for s in str(r.stdout).split(",")]:
        lst = layout.split(":")

        # Only consider well formed lists to avoid noise
        if len(lst) == 2:
            match lst[1].strip().lower():
                case "english (us)":
                    active_layouts.add("us")
                case "french":
                    active_layouts.add("fr")
                case _:
                    active_layouts.add("?")

    return "/".join(list(active_layouts))


if __name__ == "__main__":
    print(current())
