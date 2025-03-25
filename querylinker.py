#!/usr/bin/env python3

import os
import sys
from pathlib import Path

# === Configuration ===
REPO_ROOT = Path(__file__).resolve().parent
SAVED_QUERIES = REPO_ROOT / "saved_queries"
DB_QUERIES_ROOT = Path.home() / "queries"

def list_dbs():
    print("📁 Available DB folders in ~/queries:")
    for path in sorted(DB_QUERIES_ROOT.iterdir()):
        if path.is_dir():
            print(f" - {path.name}")

def list_saved_queries():
    print("📄 Available saved queries:")
    for path in sorted(SAVED_QUERIES.glob("*.sql")):
        print(f" - {path.name}")

def link_query(query_name, db_name):
    source = SAVED_QUERIES / query_name
    target_dir = DB_QUERIES_ROOT / db_name
    target = target_dir / query_name

    if not source.exists():
        print(f"❌ Query not found: {source}")
        return
    if not target_dir.exists():
        print(f"❌ DB folder does not exist: {target_dir}")
        return
    if target.exists():
        print(f"⚠️  Target already exists: {target}")
        return

    target.symlink_to(source)
    print(f"✅ Linked {query_name} → {db_name}/")

def unlink_query(query_name, db_name):
    target = DB_QUERIES_ROOT / db_name / query_name
    if target.is_symlink():
        target.unlink()
        print(f"🗑️  Removed symlink: {target}")
    else:
        print(f"❌ Not a symlink or does not exist: {target}")

def usage():
    print(f"""
Usage:
  {sys.argv[0]} list-dbs
  {sys.argv[0]} list-queries
  {sys.argv[0]} link <query.sql> <db_name>
  {sys.argv[0]} unlink <query.sql> <db_name>
""")

# === CLI ===
if __name__ == "__main__":
    if len(sys.argv) < 2:
        usage()
        sys.exit(1)

    cmd = sys.argv[1]
    if cmd == "list-dbs":
        list_dbs()
    elif cmd == "list-queries":
        list_saved_queries()
    elif cmd == "link" and len(sys.argv) == 4:
        link_query(sys.argv[2], sys.argv[3])
    elif cmd == "unlink" and len(sys.argv) == 4:
        unlink_query(sys.argv[2], sys.argv[3])
    else:
        usage()

