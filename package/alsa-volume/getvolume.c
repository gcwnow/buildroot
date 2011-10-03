// get-volume is a small utility for ALSA mixer volume, written for being used
// in Conky.
//
// This code is in Public Domain
//
// Reference:
//  http://www.alsa-project.org/alsa-doc/alsa-lib/index.html
//
// Author:
//  2009 Yu-Jie Lin
//
// Compile using:
//  gcc -lasound -o get-volume get-volume.c

#include <stdio.h>
#include <alsa/asoundlib.h>

const snd_mixer_selem_channel_id_t CHANNEL = SND_MIXER_SCHN_FRONT_LEFT;

void error_close_exit(char *errmsg, int err, snd_mixer_t *h_mixer)
{
	if (err == 0)
		fprintf(stderr, errmsg);
	else
		fprintf(stderr, errmsg, snd_strerror(err));
	if (h_mixer != NULL)
		snd_mixer_close(h_mixer);
	exit(EXIT_FAILURE);
}

int main(int argc, char** argv)
{
	int err;
	long vol;
	snd_mixer_t *h_mixer;
	snd_mixer_selem_id_t *sid;
	snd_mixer_elem_t *elem ;
	char *device;
	char *selem_name;

	if (argc < 3) {
		printf("Usage:\n\t%s device control\n", argv[0]);
		return 0;
	}

	device = argv[1];
	selem_name = argv[2];

	if ((err = snd_mixer_open(&h_mixer, 1)) < 0)
		error_close_exit("Mixer open error: %s\n", err, NULL);

	if ((err = snd_mixer_attach(h_mixer, device)) < 0)
		error_close_exit("Mixer attach error: %s\n", err, h_mixer);

	if ((err = snd_mixer_selem_register(h_mixer, NULL, NULL)) < 0)
		error_close_exit("Mixer simple element register error: %s\n", err, h_mixer);

	if ((err = snd_mixer_load(h_mixer)) < 0)
		error_close_exit("Mixer load error: %s\n", err, h_mixer);

	snd_mixer_selem_id_alloca(&sid);
	snd_mixer_selem_id_set_index(sid, 0);
	snd_mixer_selem_id_set_name(sid, selem_name);

	if ((elem = snd_mixer_find_selem(h_mixer, sid)) == NULL)
		error_close_exit("Cannot find simple element\n", 0, h_mixer);

	snd_mixer_selem_get_playback_volume(elem, CHANNEL, &vol);
	printf("%ld\n", vol);

	snd_mixer_close(h_mixer);
	return 0;
}
