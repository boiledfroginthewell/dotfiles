#!/usr/bin/env python
"""
Find WezTerm Pane by process name.
"""

from __future__ import annotations
from typing import Any
import argparse
import subprocess
import sys
import os
import shlex
import re
import json
import logging

_logger = logging.getLogger(__name__)


def _sh(cmd: str | list[str]) -> str:
    output = subprocess.run(
        shlex.split(cmd) if isinstance(cmd, str) else cmd,
        text=True,
        check=True,
        capture_output=True,
    )
    return output.stdout


def _list_tab_panes() -> list[dict[str, Any]]:
    panes = json.loads(_sh("wezterm cli list --format json"))

    current_pane = int(os.environ["WEZTERM_PANE"])
    for pane in panes:
        if pane["pane_id"] == current_pane:
            tab_id = pane["tab_id"]
    _logger.debug("tab_id=%s, current_pane=%s", tab_id, current_pane)
    return [
        pane
        for pane in panes
        if pane["tab_id"] == tab_id and pane["pane_id"] != current_pane
    ]


def _search_pane(query: str) -> dict[str, Any] | None:
    pattern = re.compile(query)
    tab_panes = _list_tab_panes()
    _logger.debug("#tab_panes=%s", len(tab_panes))
    for pane in tab_panes:
        output = _sh(["ps", "-t", pane["tty_name"], "-o", "pid=,stat=,comm=,args="])
        for ps in output.splitlines():
            _logger.debug("%s %s", pane["tty_name"], ps)
            pid, stat, comm = ps.split(maxsplit=2)
            if "+" not in stat:
                continue
            if re.search(pattern, comm):
                return pane


parser = argparse.ArgumentParser()
parser.add_argument("-v", "--verbose", action="store_true")
parser.add_argument("query", help="regex pattern for a process name")
args = parser.parse_args()

if args.verbose:
    logging.basicConfig(level=logging.DEBUG)

pane = _search_pane(args.query)
if not pane:
    print(f"no pane found for query: {args.query}", file=sys.stderr)
    sys.exit(1)

print(pane["pane_id"])
