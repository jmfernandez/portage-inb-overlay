#include <opensc/opensc.h>

char * sc_driver_version() {
	return sc_get_version();
} 
