module Shazam
include("AudioDisplay.jl")
#import Pkg; 
#Pkg.add("FFTW")
#Pkg. add("WAV")

using Plots
using FFTW
using WAV

export AB1Aufgabe1a
export AB1A1aPlay
export AB1A1bPlay
export AB1Aufgabe1b
export AB1A1c1Play
export AB1Aufgabe1c1
export AB1A1c2Play
export AB1Aufgabe1c2
export AB1A1dPlay
export AB1Aufgabe1d
export AB1A2aPlay
export AB1Aufgabe2a
export AB1A2bPlay
export AB1Aufgabe2b
export AB1ZAPlay
export AB1ZusatzaufgabeA
export AB1ZBPlay
export AB1ZusatzaufgabeB
export AB1ZCPlay
export AB1ZusatzaufgabeC
export AB1ZDPlay
export AB1ZusatzaufgabeD
export AB2A1Play
export AB2Aufgabe1
export AB2Aufgabe2b1
export AB2Aufgabe2b2
export AB2A31Play
export AB2Aufgabe31
export AB2A32Play
export AB2Aufgabe32
export AB2Zusatzaufgabe
export AB3Aufgabe1
export AB4Aufgabe1a
export AB4Aufgabe1b
export AB4Aufgabe1c

function AB1A1aPlay()
    eps = 1/44100 
    x = range(0.0,stop=2,step=eps);
    y = zeros(Float64,length(x));
    for i = 1:length(y)
        y[i] = sin(2*pi*200*x[i]);
    end
    #display(y)  
    wavwrite(y, "SinustonAB1A1a.wav", Fs=44100);
    #y, fs = wavread("SinustonAB1A1a.wav");
	#wavplay(y, fs)
	inline_audioplayer("SinustonAB1A1a.wav")
    plot(y)
end

function AB1Aufgabe1a(amplitude,frequenz)
    if amplitude!=1 || frequenz!=200
		@warn "Amplitude und/oder Frequenz falsch!"
    end
    x = 0:0.0001:0.1;
    y = zeros(1001);
    for i = 1:1001
        y[i] = amplitude*sin(2*pi*frequenz*x[i]);
    end
    labels = ["dein Ton"];
    plot(x,y, label = labels)
end

function AB1A1bPlay(amplitude_leiser, amplitude_lauter)
    eps = 1/44100 
    x = range(0.0,stop=2,step=eps);
    w = zeros(Float64,length(x));
    for i = 1:length(w)
        w[i] = sin(2*pi*200*x[i]);
    end 
    y = zeros(Float64,length(x));
    for i = 1:length(y)
        y[i] = amplitude_leiser*sin(2*pi*200*x[i]);
    end
    z = zeros(Float64,length(x));
    for i = 1:length(z)
        z[i] = amplitude_lauter*sin(2*pi*200*x[i]);
    end
    ton  = [w; y; z];
    #display(ton)
    wavwrite(ton, "SinustonAB1A1b.wav", Fs=44100);
    #ton, fs = wavread("SinustonAB1A1b.wav");
    #wavplay(ton, fs)
	inline_audioplayer("SinustonAB1A1b.wav")
	
end
    
function AB1Aufgabe1b(amplitude,amplitude_leiser,amplitude_lauter)
    if amplitude_leiser >= amplitude 
		@warn "Der erste Ton ist nicht leiser als der Ton aus Teil a)!"
    end
    if amplitude_lauter <= amplitude
		@warn "Der zweite Ton ist nicht lauter als der Ton aus Teil a)!"
    end
    x = 0:0.0001:0.1;
    y = zeros(1001,3);
    for i = 1:1001
        y[i,1] = sin(2*pi*200*x[i]);
        y[i,2] = amplitude_leiser*sin(2*pi*200*x[i]);
        y[i,3] = amplitude_lauter*sin(2*pi*200*x[i]);
    end
    labels = ["Teil a)" "leiser" "lauter"];
    plot(x,y, label = labels)
end

function AB1A1c1Play(A)
    eps = 1/44100 
    x = range(0.0,stop=2,step=eps);
    y = zeros(Float64,length(x));
    for i = 1:length(y)
        y[i] = A(x[i])*sin(2*pi*200*x[i]);
    end 
    #display(ton)
    wavwrite(y, "SinustonAB1A1c1.wav", Fs=44100);
    #y, fs = wavread("SinustonAB1A1c1.wav");
    #wavplay(y, fs)
	inline_audioplayer("SinustonAB1A1c1.wav")
end

function AB1Aufgabe1c1(A)
    if A(0) != 0
		@warn "Die Amplitude hat zur Zeit t = 0 nicht den Wert 0!"
    end
    m1 = A(1)-A(0);
    m2 = A(2)-A(1);
    if m1 != m2
		@warn "Die Funktion A besitzt kein lineares Wachstum!"
    end
    labels = ["dein Ton"];
    x = 0:0.0001:0.1;
    y = zeros(1001);
    for i = 1:1001
        y[i] = A(x[i])*sin(2*pi*200*x[i]);
    end
    plot(x,y, label = labels)
end

function AB1A1c2Play(A, A2)
    eps = 1/44100 
    x = range(0.0,stop=2,step=eps);
    y = zeros(Float64,length(x));
    for i = 1:length(y)
        y[i] = A(x[i])*sin(2*pi*200*x[i]);
    end 
    z = zeros(Float64,length(x));
    for i = 1:length(z)
        z[i] = A2(x[i])*sin(2*pi*200*x[i]);
    end 
    w = zeros(44100,1);
    ton = [y;w;z];
    #display(ton)
    wavwrite(ton, "SinustonAB1A1c2.wav", Fs=44100);
    #y, fs = wavread("SinustonAB1A1c2.wav");
    #wavplay(y, fs)
	inline_audioplayer("SinustonAB1A1c2.wav")
end

function AB1Aufgabe1c2(A,A2)
    if A2(0) != 0
		@warn "Die Amplitude hat bei t = 0 nicht den Wert 0!"
    end
    m1 = A2(1)-A2(0);
    m2 = A2(2)-A2(1);
    if m1 != m2
		@warn "Die Funktion A2 besitzt kein lineares Wachstum!"
    end
    if A(0.1) > A2(0.1)
		@warn "Die Funktion A2 wächst nicht schneller als die Funktion A!"
    end
    labels = ["Teil 1" "Teil 2"];
    x = 0:0.0001:0.1;
    y = zeros(1001,2);
    for i = 1:1001
        y[i,1] = A(x[i])*sin(2*pi*200*x[i]);
        y[i,2] = A2(x[i])*sin(2*pi*200*x[i]);
    end
    plot(x,y,label=labels)
end

function AB1A1dPlay(A)
    eps = 1/44100 
    x = range(0.0,stop=1,step=eps);
    y = zeros(Float64,length(x));
    for i = 1:length(y)
        y[i] = A(x[i])*sin(2*pi*200*x[i]);
    end 
    #display(y)
    wavwrite(y, "SinustonAB1A1d.wav", Fs=44100);
    #y, fs = wavread("SinustonAB1A1d.wav");
    #wavplay(y, fs)
	inline_audioplayer("SinustonAB1A1d.wav")
end

function AB1Aufgabe1d(A3)
    if A3(1) != 0
		@warn "Bei t = 1 hat die Amplitude nicht den Wert 0!"
    end
    m1 = A3(1)-A3(0);
    m2 = A3(2)-A3(1);
    if abs(m1 - m2) > 0.0000000001
		@warn "Die Funktion A3 besitzt kein lineares Abklingverhalten!"
    end
    labels = ["dein Ton"]; 
    x = 0:0.0001:1;
    y = zeros(length(x));
    for i = 1:length(y)
        y[i] = A3(x[i])*sin(2*pi*200*x[i]);
    end
    plot(x,y, label = labels)
end

function AB1A2aPlay(F_hoeher,F_tiefer)
    eps = 1/44100 
    x = range(0.0,stop=2,step=eps);
    y = zeros(Float64,length(x));
    for i = 1:length(y)
        y[i] = sin(2*pi*200*x[i]);
    end 
    z = zeros(Float64,length(x));
    for i = 1:length(z)
        z[i] = sin(F_hoeher*2*pi*200*x[i]);
    end
    w = zeros(Float64,length(x));
    for i = 1:length(w)
        w[i] = sin(F_tiefer*2*pi*200*x[i]);
    end
    ton = [y; z; w];
    #display(ton)
    wavwrite(ton, "SinustonAB1A2a.wav", Fs=44100);
    #ton, fs = wavread("SinustonAB1A2a.wav");
    #wavplay(ton, fs)
	inline_audioplayer("SinustonAB1A2a.wav")
end

function AB1Aufgabe2a(F_hoeher,F_tiefer)
    if F_hoeher >= 6 || F_hoeher <= 0
		@warn "F_hoeher liegt nicht zwischen 0 und 6!"
    end
    if F_tiefer >= 6 || F_tiefer <= 0
		@warn "F_tiefer liegt nicht zwischen 0 und 6!"
    end
    if F_hoeher <= 1 
		@warn "Der erste Ton ist nicht höher als der Referenzton!"
    end
    if F_tiefer >= 1
		@warn "Der zweite Ton ist nicht tiefer als der Referenzton!"
    end
    x = 0:0.00001:0.01;
    y = zeros(length(x),3);
    for i = 1:length(x)
        y[i,1] = sin(2*pi*200*x[i]);
        y[i,2] = sin(F_hoeher*2*pi*200*x[i]);
        y[i,3] = sin(F_tiefer*2*pi*200*x[i]);
    end
    labels = ["Referenz" "hoeher" "tiefer"];
    plot(x,y, label = labels)
end

function AB1A2bPlay(F)
    eps = 1/44100 
    x = range(0.0,stop=1,step=eps);
    y = zeros(Float64,length(x));
    for i = 1:length(y)
        y[i] = sin(F(x[i])*2*pi*200*x[i]);
    end 
    #display(y)
    wavwrite(y, "SinustonAB1A2b.wav", Fs=44100);
    #y, fs = wavread("SinustonAB1A2b.wav");
    #wavplay(y, fs)
	inline_audioplayer("SinustonAB1A2b.wav")
end
    
function AB1Aufgabe2b(F)
    if F(0) != 1
		@warn "Zum Zeitpunkt t = 0 hat die Frequenz von g nicht den Wert 200 Hz!"
    end
    if F(0.1) != 2
		@warn "Zum Zeitpunkt t = 0.1 hat die Frequenz von g nicht den Wert 400Hz!"
    end
    m1 = F(1)-F(0);
    m2 = F(2)-F(1);
    if abs(m1-m2) > 0.00000001
		@warn "Die Funktion F besitzt kein lineares Wachstum!"
    end
    labels = ["dein Signal"];
    x = 0:0.0001:0.1;
    y = zeros(1001);
    for i = 1:1001
        y[i] = sin(F(x[i])*2*pi*200*x[i]);
    end
    plot(x,y, label = labels)
end

function AB1ZAPlay(A,a,b)
    eps = 1/44100 
    a_ton = a - 1;
    b_ton = b + 1;
    x = range(a_ton,stop=b_ton,step=eps);
    y = zeros(Float64,length(x));
    for i = 1:length(y)
        y[i] = A(x[i])*sin(2*pi*200*x[i]);
    end 
    #display(y)
    wavwrite(y, "SinustonAB1A2b.wav", Fs=44100);
    #y, fs = wavread("SinustonAB1A2b.wav");
    #wavplay(y, fs)
	inline_audioplayer("SinustonAB1A2b.wav")
end

function AB1ZusatzaufgabeA(A4,t_min,a,b)
    if t_min <= a || t_min >= b
		@warn " t_min liegt nicht zwischen a und b!"
    end
    min = 1;
    for i = -10:10
        if A4(t_min + i/100) < A4(t_min)
            min = 0;
        end
    end
    if min == 0
		@warn "Bei t = t_min ist die Amplitude nicht minimal!"
    end
    labels = ["dein Ton"];
    if t_min > a && t_min < b 
        x = a:(b-a)/10000:b;
        y = zeros(length(x));
        for i = 1:length(y)
            y[i] = A4(x[i])*sin(2*pi*200*x[i]);
        end
        plot(x,y, label = labels)
    end
end

function AB1ZBPlay(A,a,b)
    eps = 1/44100 
    x = range(a,stop=b,step=eps);
    y = zeros(Float64,length(x));
    for i = 1:length(y)
        y[i] = A(x[i])*sin(2*pi*50*x[i]);
    end 
    #display(y)
    wavwrite(y, "SinustonAB1ZB.wav", Fs=44100);
    #y, fs = wavread("SinustonAB1ZB.wav");
    #wavplay(y, fs)
	inline_audioplayer("SinustonAB1ZB.wav")
end
  
function AB1ZusatzaufgabeB(A5,t_max,a,b)
    if t_max <= a || t_max >= b
		@warn "t_max liegt nicht zwischen a und b!"
    end
    if A5(a) != 0 
		@warn "Bei t = a hat die Amplitude nicht den Wert 0!"
    end
    if A5(b) != 0
		@warn "Bei t = b hat die Amplitude nicht den Wert 0!"
    end
    max = 1;
    for i = -10:10
        if A5(t_max + i/100) > A5(t_max)
            max = 0;
        end
    end
    if max == 0
		@warn "Bei t = t_max ist die Amplitude nicht maximal!"
    end
    labels = ["dein Ton"];
    if t_max > a && t_max < b 
        x = a:(b-a)/10000:b;
        y = zeros(length(x));
        for i = 1:length(y)
            y[i] = A5(x[i])*sin(2*pi*50x[i]);
        end
        plot(x,y, label = labels)
    end
end

function AB1ZCPlay(a,F)
    eps = 1/44100
    b = a + 1;
    x = range(a,stop=b,step=eps);
    y = zeros(Float64,length(x));
    for i = 1:length(y)
        y[i] = sin(F(x[i])*2*pi*200*x[i]);
    end 
    #display(y)
    wavwrite(y, "SinustonAB1ZC.wav", Fs=44100);
    #y, fs = wavread("SinustonAB1ZC.wav");
    #wavplay(y, fs)
	inline_audioplayer("SinustonAB1ZC.wav")
end
    

function AB1ZusatzaufgabeC(a,b,F)
    if b <= a 
		@warn "b muss größer sein als a!"
    end
    increase = 1;
    for i = 1:100
        if F(a+(b-a)/100*i) < F(a+(b-a)/100*(i+1))
            increase = 0;
        end
    end
    if increase == 0
		@warn "Die Frequenz fällt nicht auf dem Intervall [a,b]!"
    end
    labels = ["dein Signal"];
    if a < b
        x = a:(b-a)/10000:b;
        y = zeros(length(x));
        for i = 1:length(y)
            y[i] = sin(F(x[i])*2*pi*200*x[i]);
        end
        plot(x,y, label = labels)
    end
end

function AB1ZDPlay(a,b,F)
    eps = 1/44100
    x = range(a,stop=b,step=eps);
    y = zeros(Float64,length(x));
    for i = 1:length(y)
        y[i] = sin(F(x[i])*2*pi*200*x[i]);
    end 
    #display(y)
    wavwrite(y, "SinustonAB1ZD.wav", Fs=44100);
    #y, fs = wavread("SinustonAB1ZD.wav");
    #wavplay(y, fs)
	inline_audioplayer("SinustonAB1ZD.wav")
end
    
function AB1ZusatzaufgabeD(a,b,F)
    if b <= a
		@warn "b muss größer sein als a!"
    end
    labels = ["dein Signal"];
    if a < b
        x = a:(b-a)/10000:b;
        y = zeros(length(x));
        for i = 1:length(y)
            y[i] = sin(F(x[i])*2*pi*200*x[i]);
        end
        plot(x,y, label = labels)
    end
end

function AB2A1Play(g)
    eps = 1/44100
    x = range(0.0,stop=2,step=eps);
    y = zeros(Float64,length(x));
    for i = 1:length(y)
        y[i] = g(x[i]);
    end 
    #display(y)
    wavwrite(y, "SinustonAB2A1.wav", Fs=44100);
    #y, fs = wavread("SinustonAB2A1.wav");
    #wavplay(y, fs)
	inline_audioplayer("SinustonAB2A1.wav")
end
    
function AB2Aufgabe1(g)
    x = 0:0.0001:0.1;
    y = zeros(length(x));
    for i = 1:length(y)
        y[i] = g(x[i]);
    end
    labels = ["dein Dreiklang"];
    plot(x,y, label = labels)
end

function AB2Aufgabe2b1(g)
    samplingrate = 44100;
    x = 0:1/44100:6;
    y = zeros(length(x));
    for i = 1:length(y)
        y[i] = g(x[i]);
    end
    yfft = fft(y);
    f = zeros(length(yfft));
    for i = 1:length(yfft)
        f[i] = (i-1)*samplingrate/length(yfft);
    end
    fplot = f[1:5000];
    yplot = yfft[1:5000];
    yfind = abs.(yplot);
    m1, ind1 = findmax(yfind);
    yfind[ind1] = 0;
    m2, ind2 = findmax(yfind);
    yfind[ind2] = 0;
    m3, ind3 = findmax(yfind);
    labels = ["Frequenzspektrum"];
    plot(fplot,abs.(yplot)/m3, label = labels)
end

function AB2Aufgabe2b2(g)
    samplingrate = 44100;
    x = 0:1/44100:6;
    y = zeros(length(x));
    for i = 1:length(y)
        y[i] = g(x[i]);
    end
    yfft = fft(y);
    f = zeros(length(yfft));
    for i = 1:length(yfft)
        f[i] = (i-1)*samplingrate/length(yfft);
    end
    fplot = f[1:5000];
    yplot = yfft[1:5000];
    yfind = abs.(yplot);
    m1, ind1 = findmax(yfind);
    yfind[ind1] = 0;
    m2, ind2 = findmax(yfind);
    yfind[ind2] = 0;
    m3, ind3 = findmax(yfind);
    print("Frequenz 1 = ", f[ind1], "     Frequenz 2 = ", f[ind2], "     Frequenz 3 = ", f[ind3])
end

function AB2A31Play(y1,y2,y3)
    eps = 1/44100 
    x = range(0.0,stop=2,step=eps);
    y = zeros(Float64,length(x));
    for i = 1:length(y)
        y[i] = y1(x[i]);
    end 
    z = zeros(Float64,length(x));
    for i = 1:length(z)
        z[i] = y2(x[i]);
    end
    w = zeros(Float64,length(x));
    for i = 1:length(w)
        w[i] = y3(x[i]);
    end
    ton = [y; z; w];
    #display(ton)
    wavwrite(ton, "SinustonAB2A31.wav", Fs=44100);
    #ton, fs = wavread("SinustonAB2A31.wav");
    #wavplay(ton, fs)
	inline_audioplayer("SinustonAB2A31.wav")
end
    
function AB2Aufgabe31(y1,y2,y3)
    x = 0:0.00001:0.01;
    y = zeros(length(x),3);
    for i = 1:length(x)
        y[i,1] = y1(x[i]);
        y[i,2] = y2(x[i]);
        y[i,3] = y3(x[i]);
    end
    labels = ["y1" "y2" "y3"];
    plot(x,y, label = labels)
end

function AB2A32Play(S)
    eps = 1/44100
    x = range(0.0,stop=2,step=eps);
    y = zeros(Float64,length(x));
    for i = 1:length(y)
        y[i] = S(x[i]);
    end 
    #display(y)
    wavwrite(y, "SinustonAB2A32.wav", Fs=44100);
    #y, fs = wavread("SinustonAB2A32.wav");
    #wavplay(y, fs)
	inline_audioplayer("SinustonAB2A32.wav")
end
    
function AB2Aufgabe32(S)
    x = 0:0.00001:0.01;
    y = zeros(length(x));
    for i = 1:length(x)
        y[i] = S(x[i]);
    end
    labels = ["S"];
    plot(x,y, label = labels)
end

function AB2Zusatzaufgabe(F)
    saeg(t) = mod2pi(t+pi)-pi;
    x = -2*pi:0.01:2*pi;
    y = zeros(length(x),2);
    for i = 1:length(x)
        y[i,1] = F(x[i]);
        y[i,2] = saeg(x[i]);
    end
    labels = ["F" "Saegezahnfunktion"];
    plot(x,y, label = labels)
end

function AB3Aufgabe1(pointFreq_8,T_delta_8,anchorFreq_3,pointFreq_10,anchorFreq_4,pointFreq_11_2,T_delta_11_2,anchorFreq_6,pointFreq_16_2,T_delta_16_2,pointFreq_17_2,T_delta_17_2,pointFreq_18,T_delta_18,pointFreq_19,T_delta_19,pointFreq_20,T_delta_20)
    if pointFreq_8 != 40
		@warn "Frequenz von Datenpunkt 8 ist falsch!"
    end
    if T_delta_8 != 4
		@warn "Abstand von Datenpunkt 8 zum Anchor Point 2 stimmt nicht!"
    end
    if anchorFreq_3 != 10
		@warn "Frequenz von Anchor Point 3 stimmt nicht!"
    end
    if pointFreq_10 != 50
		@warn "Frequenz von Datenpunkt 10 stimmt nicht!"
    end 
    if anchorFreq_4 != 50
		@warn "Frequenz von Anchor Point 4 stimmt nicht!"
    end
    if pointFreq_11_2 != 10
		@warn "Frequenz von Datenpunkt 11 stimmt nicht!"
    end
    if T_delta_11_2 != 1
		@warn "Abstand von Datenpunkt 11 zu Anchor Point 4 stimmt nicht!"
    end
    if anchorFreq_6 != 30
		@warn "Frequenz von Anchor Point 6 stimmt nicht!"
    end
    if pointFreq_16_2 != 30
		@warn "Frequenz von Datenpunkt 16 stimmt nicht!"
    end
    if T_delta_16_2 != 0
		@warn "Abstand von Datenpunkt 16 zum Anchor Point 6 stimmt nicht!"
    end
    if pointFreq_17_2 != 20
		@warn "Frequenz von Datenpunkt 17 stimmt nicht!"
    end
    if T_delta_17_2 != 1
		@warn "Abstand von Datenpunkt 17 zu Anchor Point 6 stimmt nicht!"
    end
    if pointFreq_18 != 40 
		@warn "Frequenz von Datenpunkt 18 stimmt nicht!"
    end
    if T_delta_18 != 2
		@warn "Abstand zwischen Datenpunkt 18 und Anchor Point 6 stimmt nicht!"
    end
    if pointFreq_19 != 10 
		@warn "Frequenz von Datenpunkt 19 stimmt nicht!"
    end
    if T_delta_19 != 3
		@warn "Abstand zwischen Datenpunkt 19 und Anchor Point 6 stimmt nicht!"
    end
    if pointFreq_20 != 30
		@warn "Frequenz von Datenpunkt 20 stimmt nicht!"
    end
    if T_delta_20 != 4
		@warn "Abstand von Datenpunkt 20 zu Anchor Point 6 stimmt nicht!"
    end
end

function AB4Aufgabe1a(Spalte3,Spalte4)
    Spalte2 = [22; 22; 22; 49; 49; 34; 34; 34; 85; 49; 58; 58; 58; 58; 58; 19; 19; 19; 67; 67; 82; 82; 52; 70; 70; 25; 25; 25; 40; 40];
    if Spalte3 != [1; 1; 1; 1; 1; 4; 4; 4; 4; 4; 7; 7; 7; 7; 7; 10; 10; 10; 10; 10; 13; 13; 13; 13; 13; 16; 16; 16; 16; 16]
		@warn "Spalte3 ist falsch!"
    end
    Spalte4_temp = Spalte2 - Spalte3;
    if Spalte4 !=  Spalte4_temp
		@warn "Spalte4 ist falsch!"
    end
    print("Spalte4 = ", Spalte4)
end

function AB4Aufgabe1b(Spalte2,Spalte3,Spalte4)
    if Spalte2 != [52; 52; 52; 52; 52; 55; 55; 55; 55; 55; 58; 58; 58; 58; 58; 61; 61; 61; 61; 61; 64; 64; 64; 64; 64; 67; 67; 67; 67; 67];
		@warn "Spalte2 ist falsch!"
    end
    if Spalte3 != [1; 1; 1; 1; 1; 4; 4; 4; 4; 4; 7; 7; 7; 7; 7; 10; 10; 10; 10; 10; 13; 13; 13; 13; 13; 16; 16; 16; 16; 16]
		@warn "Spalte3 ist falsch!"
    end
    Spalte4_temp = Spalte2 - Spalte3;
    if Spalte4 !=  Spalte4_temp
		@warn "Spalte4 ist falsch!"
    end
    print("Spalte4 = ", Spalte4)
end

function AB4Aufgabe1c(N)
    if N != 2
		@warn "Falsch!"
    end
    if N == 2
        print("Richtig, Song02 ist der gesuchte Song!")
    end
end

end
