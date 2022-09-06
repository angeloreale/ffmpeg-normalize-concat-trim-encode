#!/bin/zsh
for file in (*.mp3|*.aiff|*.wav); do \
echo "\e[1;97;41mStarting to normalize...\e[0;39;49m"; \
ffmpeg -i $file -af loudnorm=I=-16:LRA=11:TP=-1.5 loudnorm-$(basename $file).mp3; \
echo "\e[1;97;41mFinished normalizing...\e[0;39;49m"; \
cat /dev/null > merge.txt; \
echo "file '/path/to/jingle.mp3'" >> merge.txt; \
echo "file './loudnorm-$(basename $file).mp3'" >> merge.txt; \
echo "\e[1;97;41mStarting to encode...\e[0;39;49m"; \
ffmpeg -f concat -safe 0 -i merge.txt -af silenceremove=start_periods=1:start_silence=0.1:start_threshold=-60dB,areverse,silenceremove=start_periods=1:start_silence=0.1:start_threshold=-60dB,areverse  STEM-audio-$(basename $file).mp3 -b:a 64K -af silenceremove=start_periods=1:start_silence=0.1:start_threshold=-60dB,areverse,silenceremove=start_periods=1:start_silence=0.1:start_threshold=-60dB,areverse 64-loudnorm-audio-$(basename $file).mp3; \
echo "\e[1;97;41mFinished encoding!\e[0;39;49m"; \
done
