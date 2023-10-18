#!/usr/bin/python

""" Show DB tables from raw Data Definition Language.

Implemented in python 3.11.
"""

from sys import argv, exit
from enum import StrEnum
from dataclasses import dataclass
from typing import Any, Self


def show_help_then_exit():
    _help = "Show DB tables from raw Data Definition Language."
    print(_help)
    exit(0)


def cli() -> str:
    """Reads cli args, returns file to read on success."""
    file = ""
    match argv:
        case [_, "-f" | "--file", _]:
            file = argv[2]
        case [_, "-h" | "--help"]:
            show_help_then_exit()
        case _:
            print("error, arguments are not supported")
            print(argv)
            exit(1)
    return file


@dataclass
class Table:
    """Interesting sql tables' metadata."""

    name: str
    # Any stands for Table here but recursive definitions
    # are not possible
    foreign_key: list[Any] | None = None


class L1(StrEnum):
    Create = "create"
    Drop = "drop"
    Noop = "noop"


class L2(StrEnum):
    CreateFk = "foreign"
    Noop = "noop"


class Lexer:
    def __init__(self):
        self._syntax = [
            [
                L1.Create,
                L1.Drop,
            ],
            [
                {
                    L1.Create: [
                        L2.CreateFk,
                    ],
                },
            ],
        ]

    def l1(self, tokens: list[str]) -> L1:
        match tokens:
            case [L1.Create, "table", _] as d:
                return L1.Create
            case [L1.Drop, "table", _] as d:
                return L1.Drop
            case _:
                return L1.Noop

    def l2(self, tokens: list[str]) -> L2:
        match tokens:
            case [L2.CreateFk, *foreign_args]:
                try:
                    # The referenced table is right after the 'references' token
                    i = foreign_args.index("references")
                    if len(foreign_args) > i + 2:
                        return L2.CreateFk
                except ValueError:
                    return L2.Noop
            case _:
                return L2.Noop


class ParseError(Exception):
    ...


class L1ParseError(ParseError):
    ...


class L2ParseError(ParseError):
    ...


class Grammar:
    def __init__(self, lexer: Lexer, file: str):
        self._lexer = lexer
        self._file = file

    def _tokenize(self, line: str) -> list[str]:
        def replace_any(s: str, source: str, replacement: str) -> str:
            for c in source:
                s = s.replace(c, replacement)
            return s

        separators = "(),"
        return replace_any(line.lower(), separators, " ").split()

    def _parse_l1_create(self, tokens: list[str]) -> Table:
        match tokens:
            case [L1.Create, "table", _] as d:
                return Table(name=d[2])
            case _:
                raise L1ParseError("couldn't parse create")

    def _parse_l1_drop(self, tokens: list[str]) -> Table:
        match tokens:
            case [L1.Drop, "table", _] as d:
                return Table(name=d[2])
            case _:
                raise L1ParseError("couldn't parse drop")

    def _parse_l2_fk(self, tokens: list[str], table: Table) -> Table:
        match tokens:
            case [L2.CreateFk, *foreign_args]:
                try:
                    # The referenced table is right after the 'references' token
                    i = foreign_args.index("references")
                    if len(foreign_args) < i + 2:
                        raise L2ParseError("missing reference name")

                    if table.foreign_key is None:
                        table.foreign_key = []
                    table.foreign_key.append(Table(name=foreign_args[i + 1]))
                except ValueError:
                    ...
                finally:
                    return table

    def parse(self) -> tuple[L1, Table] | None:
        with open(self._file) as f:
            for line in f:
                backtrack_l1 = True

                # L1 statements are used as delimiters
                # Therefore when parsing L2 is finished
                # A L1 is being read at the L2 level.
                # As a consequence current L1 must be reread
                # (backtracked) so that it's content is not overwritten
                # by the next line.
                while backtrack_l1:
                    backtrack_l1 = False

                    tokens = self._tokenize(line)
                    match self._lexer.l1(tokens):
                        case L1.Create:
                            table = self._parse_l1_create(tokens)
                            for line in f:
                                tokens = self._tokenize(line)
                                match self._lexer.l2(tokens):
                                    case L2.CreateFk:
                                        table = self._parse_l2_fk(tokens, table)
                                    case _:
                                        if self._lexer.l1(tokens) != L1.Noop:
                                            backtrack_l1 = True
                                            break
                            yield (L1.Create, table)
                        case L1.Drop:
                            table = self._parse_l1_drop(tokens)
                            yield (L1.Drop, table)
                        case L1.Noop:
                            yield None
        return None


def tables(file: str) -> dict[str:Table]:
    """Returns a list of tables."""
    tables: dict[str:Table] = {}
    # for cmd in command(file):
    for cmd in Grammar(lexer=Lexer(), file=file).parse():
        match cmd:
            case (L1.Create, _) as c:
                tables[c[1].name] = c[1]
            case (L1.Drop, _) as c:
                name = c[1].name
                if name in tables:
                    del tables[name]
            case _:
                ...

    return tables


def print_tables(tables: dict[str:Table]):
    """Prints table list on stdout."""
    tt = sorted([t for t in tables.values()], key=lambda e: e.name)
    for t in tt:
        print(t.name)
        if t.foreign_key is not None:
            for fk in t.foreign_key:
                print(f"  -> {fk.name}")


print_tables(tables(cli()))
