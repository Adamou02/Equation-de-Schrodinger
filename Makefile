## Configuration

# Compilateur
CC = gcc -c
CFLAGS = -Wall -pedantic

# Editeur de liens
LD = gcc
LDFLAGS = -lgsl -lgslcblas -lm

# gnuplot
GP = gnuplot
GPFLAGS = -p -c

## Fichiers
PROJECT = schrodinger

# Fichiers
HDR = $(wildcard src/*.h)
SRC = $(wildcard src/*.c)
OBJ = $(SRC:src/%.c=obj/%.o)
BIN = ./$(PROJECT)
DAT = $(PROJECT).dat
GPI = $(PROJECT).gpi
IMG = $(PROJECT).png

# 'clean' et 'reset' ne sont pas des noms de vrais fichiers
.PHONY : clean reset

## Dépendances

# Graphique gnuplot
$(IMG) : $(GPI) $(DAT)
	$(GP) $(GPFLAGS) $<

# Fichier de données
$(DAT) : $(BIN)
	$(BIN)

# Edition des liens
$(BIN) : $(OBJ)
	$(LD) $^ $(LDFLAGS) -o $@

# Compilation
obj/%.o : src/%.c src/equadiff.h src/consts.h
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) $< -o $@

# Compilation : règle par défaut
obj/%.o : src/%.c
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) $< -o $@

# Règles de nettoyage
clean :
	rm -rf obj
reset : clean
	rm $(BIN) $(DAT) $(IMG)
