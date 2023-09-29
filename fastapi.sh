#!/bin/bash

# Define the folder name
folder_name="app"

# Create the folder if it doesn't exist
if [ ! -d "$folder_name" ]; then
  mkdir "$folder_name"
fi

# Define the content for main.py
main_py_content="from fastapi import FastAPI\n\napp = FastAPI()\n\n@app.get('/')\ndef index():\n\treturn 'Hello Fast API'"

# Create or overwrite main.py in the app folder with the defined content
echo -e "$main_py_content" > "$folder_name/main.py"
# Make main.py executable (optional)
chmod +x "$folder_name/main.py"
echo "[1] main.py has been generated in the $folder_name folder."

requirement_content="uvicorn==0.23.2\nfastapi==0.103.1"
echo -e "$requirement_content" > "requirements.txt"
chmod +x "requirements.txt"
echo "[2] requirements.txt has been generated."

python3 -m venv devenv
echo "[3] devenv has been generated."

scripts_content="uvicorn app.main:app --reload\nsource devenv/bin/activate\ndeactivate"
echo -e "$scripts_content" > "scripts.txt"
echo "[4] devenv has been generated."

echo "Library installing ... "
source devenv/bin/activate
pip3 install -r requirements.txt
echo "-----------------------------------------------"
echo "[5] Installation done."
echo "[6] Run with : ' uvicorn app.main:app --reload '"
echo "-----------------------------------------------"
deactivate
