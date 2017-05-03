C_COMPILER=gcc

UNITY_ROOT = Unity

CFLAGS = -std=c89
CFLAGS += -Wall
CFLAGS += -Wextra
CFLAGS += -Wpointer-arith
CFLAGS += -Wcast-align
CFLAGS += -Wwrite-strings
CFLAGS += -Wswitch-default
CFLAGS += -Wunreachable-code
CFLAGS += -Winit-self
CFLAGS += -Wmissing-field-initializers
CFLAGS += -Wno-unknown-pragmas
CFLAGS += -Wstrict-prototypes
CFLAGS += -Wundef
CFLAGS += -Wold-style-definition

SRC_FILES1 = $(UNITY_ROOT)/src/unity.c
SRC_FILES1 += test/TestCode.c
SRC_FILES1 += build/TestRunner.c

INC_DIRS = -Isrc -I$(UNITY_ROOT)/src

BUILD_DIR = build
TARGET1 = $(BUILD_DIR)/test1.out

all: clean default

clean:
	rm -rf build

default: $(BUILD_DIR) $(TARGET1)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(TARGET1): $(SRC_FILES1)
	$(C_COMPILER) $(CFLAGS) $(INC_DIRS) $(SRC_FILES1) -o $(TARGET1)
	$(TARGET1)

build/TestRunner.c: test/TestCode.c
	ruby $(UNITY_ROOT)/auto/generate_test_runner.rb test/TestCode.c build/TestRunner.c

ci: CFLAGS += -Werror
ci: default
