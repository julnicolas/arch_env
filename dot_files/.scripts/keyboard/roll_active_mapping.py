""" Rolls to the next supported mapping from the currently active one.

Mappings must be set manually if several different are currently active.
"""
import logging as log
import mappings
import subprocess
from typing import List

supported_mappings = [
    "us", # US qwerty
    "fr", # French Azerty
]

def _next(lst: List[str], item: str) -> int:
    """ returns the next item in the list, rolling to start
    if end is reached. 

    Raises ValueError if not found.
    """
    i = lst.index(item)
    return lst[0] if i ==  len(lst) - 1 else lst[i+1]


def roll(map_lst: List[str]) -> None:
    """ Enables next mapping in the supported_mapping list.
    It starts from the list of supported mappings. """
    try:
        nxt = _next(map_lst, mappings.current())
        cmd = f"swaymsg input type:keyboard xkb_layout {nxt}"

        # Run command with next layout in the list
        r = subprocess.run(cmd, shell=True, timeout=2,)
        if r.returncode != 0:
            log.error("could not update keyboard mapping")
            os.exit(1)

    except ValueError:
        log.error("mapping detection is not functional")
        os.exit(1)

if __name__ == "__main__":
    roll(supported_mappings)
