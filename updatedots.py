#!/bin/env python3
# Autor: (at)rodolphocostach
# Script: updatedots.py
# Funcao: Copiar atualizar os dots no diretorio do repositorio (atual)

import socket
import os
from distutils.dir_util import copy_tree

# Nome do SO para organização como pasta
sistema = socket.gethostname()
configdir = os.path.expanduser("~/.config")

# Ve se a pasta já existe e se não existir cria
diretorio = os.path.exists(sistema)
if not diretorio:
    os.makedirs(sistema)

# Bora para a copia
apps = open('configdirs.txt', 'r')

for app in apps:
    origem = configdir + "/" + (app.rstrip('\n')).strip()
    destino = sistema + "/" + (app.rstrip('\n')).strip()
    copy_tree(origem, destino)