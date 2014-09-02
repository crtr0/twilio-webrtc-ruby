function visualizeMediaStream(stream) {

	audioContext = new webkitAudioContext();
	analyser = audioContext.createAnalyser();
	microphone = audioContext.createMediaStreamSource(stream);
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
