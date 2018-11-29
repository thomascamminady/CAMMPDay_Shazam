using WAV
using IJulia

function inline_audioplayer(filepath)
  markup = """<audio controls="controls" {autoplay}>
              <source src="$filepath" type="audio/wav" />
              Your browser does not support the audio element.
              </audio>"""
  display(MIME("text/html") ,markup)
end

#function inline_audioplayer(s, fs)
#    buf = IOBuffer()
#    wavwrite(s, buf; Fs=fs)
#    data = base64(unsafe_string(buf)) 
#    markup = """<audio controls="controls" {autoplay}>
#                <source src="data:audio/wav;base64,$data" type="audio/wav" />
#                Your browser does not support the audio element.
#                </audio>"""
#    display(MIME("text/html") ,markup)
#end
