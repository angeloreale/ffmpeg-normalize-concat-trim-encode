#!/bin/zsh
for file in (*.mp3|*.aiff|*.wav); do \
echo "\e[1;97;43mStarting to trim...\e[0;39;49m"; \
ffmpeg -i $file -b:a 320K -af silenceremove=start_periods=1:start_silence=0.1:start_threshold=-50dB,areverse,silenceremove=start_periods=1:start_silence=0.1:start_threshold=-50dB,areverse trim.mp3; \
echo "\e[1;97;42mFinished trimming...\e[0;39;49m"; \
echo "\e[1;97;43mStarting to normalize...\e[0;39;49m"; \
ffmpeg -i trim.mp3 -b:a 320K -af loudnorm=I=-16:LRA=11:TP=-1.5 loudnorm.mp3; \
echo "\e[1;97;42mFinished normalising...\e[0;39;49m"; \
echo "\e[1;97;43mStarting to encode...\e[0;39;49m"; \
cat /dev/null > merge.txt; \
echo "file '/path/to/jingle.mp3'" >> merge.txt; \
echo "file './loudnorm.mp3'" >> merge.txt; \
ffmpeg -f concat -safe 0 -i merge.txt -b:a 320K k320-$(basename $file).mp3 -b:a 64K k64-$(basename $file).mp3; \
echo "\e[1;97;42mFinished encoding!\e[0;39;49m"; \
done


