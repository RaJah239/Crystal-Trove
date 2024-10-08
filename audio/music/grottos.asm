Music_Grottos:
	musicheader 4, 1, Music_HiddenGrotto_Ch1
	musicheader 1, 2, Music_HiddenGrotto_Ch2
	musicheader 1, 3, Music_HiddenGrotto_Ch3
	musicheader 1, 4, Music_HiddenGrotto_Ch4

Music_HiddenGrotto_Ch1:
	dutycycle 2
	vibrato $12, $15
	tempo 188
	notetype $c, $92
	octave 4
	note F#, 2
	note E_, 2
	note D_, 2
	note C_, 16
	note __, 2
	note C_, 2
	note F#, 16
	note __, 10
	note F#, 2
	note E_, 2
	note D_, 2
	note C_, 16
	note __, 3
	octave 3
	note G_, 16
	note __, 4
	octave 4
	note C_, 16
	note __, 4
	loopchannel 0, Music_HiddenGrotto_Ch1

Music_HiddenGrotto_Ch2:
	dutycycle 2
	vibrato $12, $15
	notetype $6, $52
	octave 4
	note __, 1
Music_HiddenGrotto_Ch2_loop:
	notetype $c, $52
	note F#, 2
	note E_, 2
	note D_, 2
	note C_, 2
	note __, 16
	note C_, 2
	note F#, 10
	note __, 16
	note F#, 2
	note E_, 2
	note D_, 2
	note C_, 6
	note __, 13
	octave 3
	note G_, 4
	note __, 16
	octave 4
	note C_, 4
	note __, 16
	loopchannel 0, Music_HiddenGrotto_Ch2_loop
	
Music_HiddenGrotto_Ch3:
	vibrato $12, $15
	notetype $c, $35
	octave 3
	note D_, 2
	note C_, 2
	octave 2
	note A_, 2
	note G_, 2
	note __, 16
	note G_, 2
	octave 3
	note D_, 2
	note __, 16
	note __, 8
	note D_, 2
	note C_, 2
	octave 2
	note A_, 2
	note G_, 2
	note __, 16
	note __, 1
	note E_, 2
	note __, 16
	note __, 2
	note G_, 2
	note __, 16
	note __, 2
	loopchannel 0, Music_HiddenGrotto_Ch3
	
Music_HiddenGrotto_Ch4:
	notetype $6
	togglenoise $5
Music_HiddenGrotto_Ch4_loop:
	note __, 16
	note __, 6
	note D#, 5
	note E_, 1
	note E_, 1
	note E_, 1
	note E_, 1
	note E_, 1
	note E_, 1
	note E_, 2
	note C_, 13
	note __, 8
	note __, 16
	note D#, 1
	note D#, 1
	note D#, 1
	note D#, 1
	note D#, 2
	note E_, 10
	note __, 16
	note __, 16
	note __, 8
	note D_, 1
	note D_, 1
	note D_, 1
	note D_, 1
	note D_, 2
	note D_, 3
	note D_, 3
	note D#, 8
	note __, 14
	note E_, 1
	note E_, 1
	note E_, 1
	note E_, 1
	note E_, 1
	note B_, 2
	note C_, 13
	note __, 16
	note __, 8
	note D#, 1
	note D#, 1
	note D#, 1
	note D#, 16
	note __, 9
	loopchannel 0, Music_HiddenGrotto_Ch4_loop