#include <fcntl.h>
#include <linux/vt.h>
#include <linux/kd.h>
#include <stdio.h>
#include <sys/ioctl.h>
#include <unistd.h>

#define FB_TTY "/dev/tty%i"

int main(int argc, char **argv)
{
	int i;
	int fd;
	char tty[10];

	for (i=0; i < 10; i++) {
		int mode;

		sprintf(tty, FB_TTY, i);
		fd = open(tty, O_RDWR);
		if (fd < 0)
		  continue;

		if (ioctl(fd, KDGETMODE, &mode) < 0) {
			fprintf(stderr, "Unable to get mode for tty %i.\n", i);
			close(fd);
			return 1;
		}

		if (mode != KD_TEXT)
		  break;

		close(fd);
	}

	if (i==10) {
		printf("No graphic tty found.\n");
		return 1;
	}

	printf("Graphic tty found on %s.\n", tty);

	if (ioctl(fd, KDSETMODE, KD_TEXT) < 0)
		fprintf(stderr, "Unable to set keyboard mode.\n");

	if (ioctl(fd, VT_UNLOCKSWITCH, 1) < 0)
		fprintf(stderr, "Unable to unlock terminal.\n");

	close(fd);
	return 0;
}
