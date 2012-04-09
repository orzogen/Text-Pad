require 'rubygems'
require 'sinatra'
require 'haml'
enable :sessions
set :port, 3000







get '/' do
	@text = ''
	if session['text'] 
		@text = session['text']
	end
	haml :page
end

post '/post/:text' do
	session['text'] = params[:text].to_s.gsub(/\.\W/, '. ').gsub(/\|\|/, "?").gsub(/---/, "#")
end







__END__

@@page

%html
	%head
		%title Text Writer
		%script{:src => 'https://raw.github.com/madrobby/keymaster/master/keymaster.min.js'}
		%script{:src => 'https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js'}
		%script
			key('control+s, ctrl+s', function(){
			var data = $('#text').val().replace(/\?/g, "||").replace(/#/g, "---");
			$.ajax({type: "POST", url: "http://localhost:3000/post/" + data}); 
			});
			
			
		:css
			#text{
				position: absolute;
				left: 7%;
				top: 15%;
				border: none;
				font-family: helvetica, Arial, sans-serif;
				font-size: 2em;
				width: 60%;
				height: 70%;
				outline: none;
				resize: none;	
			}
		
			#text:-moz-placeholder {
				-moz-animation-name: glow;
				-moz-animation-timing-function: ease-in-out;
				-moz-animation-iteration-count: infinite;
				-moz-animation-duration: 3s;
				-moz-animation-direction: alternate;
			}
		
			#text::-webkit-input-placeholder {
				-webkit-animation-name: glow;
				-webkit-animation-timing-function: ease-in-out;
				-webkit-animation-iteration-count: infinite;
				-webkit-animation-duration: 2s;
				-webkit-animation-direction: alternate;
			}
		
		
			@-webkit-keyframes glow{
				0% {opacity: 0;}
				100% {opacity: 1;}
			}
		
			@-moz-keyframes glow{
				0% {opacity: 0;}
				100% {opacity: 1;}
			}
	%body
		%textarea#text{:placeholder => 'Type here.'}= @text
		