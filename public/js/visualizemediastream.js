/**
 * Pass in a MediaStream and its volume will be visualized
 */
function visualizeMediaStream(stream) {

	// the context in which all the audio processing will take place
	audioContext = new webkitAudioContext();
	// the analyser can expose time and frequency data
	analyser = audioContext.createAnalyser();
	// connect our WebRTC media stream to the audio context
	microphone = audioContext.createMediaStreamSource(stream);
	// the script processor will let us sample the audio 
	scriptProcessor = audioContext.createScriptProcessor(2048, 1, 1);

	analyser.smoothingTimeConstant = 0.3;
	analyser.fftSize = 1024;

	microphone.connect(analyser);
	analyser.connect(scriptProcessor);
	scriptProcessor.connect(audioContext.destination);

	scriptProcessor.onaudioprocess = function() {
	    var array =  new Uint8Array(analyser.frequencyBinCount);
	    analyser.getByteFrequencyData(array);
	    var values = 0;

	    var length = array.length;
	    for (var i = 0; i < length; i++) {
	        values += array[i];
	    }

	    average = values / length;
        circle.attr("r", average * 2);

	};
	
}
