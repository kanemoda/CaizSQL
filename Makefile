###############################################################################
# Makefile for a basic C project with directories for:
#   - include/  (header files)
#   - src/      (source files)
#   - lib/      (compiled object files)
#   - bin/      (final executable)
#
# Usage:
#   make          (build the executable)
#   make clean    (remove object files and the executable)
###############################################################################

# Compiler and flags
CC      := gcc
CFLAGS  := -Wall -Wextra -pedantic -I include

# Directories
SRC_DIR     := src
INCLUDE_DIR := include
LIB_DIR     := lib
BIN_DIR     := bin

# Target names
TARGET  := tree               # Name of the final executable
SOURCES := $(SRC_DIR)/tree.c  # For now, just one .c file
OBJECTS := $(patsubst $(SRC_DIR)/%.c,$(LIB_DIR)/%.o,$(SOURCES))

###############################################################################
# Default rule: build the executable
###############################################################################
all: $(BIN_DIR)/$(TARGET)

###############################################################################
# Link step: combine object files into the final executable
###############################################################################
$(BIN_DIR)/$(TARGET): $(OBJECTS)
	@echo "  Linking $@"
	@mkdir -p $(BIN_DIR)
	$(CC) $(CFLAGS) -o $@ $^
	@echo "Build complete: $@"

###############################################################################
# Compilation step: compile .c -> .o (placed in lib/)
###############################################################################
$(LIB_DIR)/%.o: $(SRC_DIR)/%.c $(INCLUDE_DIR)/%.h
	@mkdir -p $(LIB_DIR)
	@echo "  Compiling $<"
	$(CC) $(CFLAGS) -c $< -o $@

###############################################################################
# Clean rule: remove object files and the final executable
###############################################################################
clean:
	@echo "  Cleaning..."
	rm -f $(LIB_DIR)/*.o
	rm -f $(BIN_DIR)/$(TARGET)

###############################################################################
# Declare targets that are not files
###############################################################################
.PHONY: all clean
