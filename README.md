# jiaotongdeng-VHDL
1、基本功能：无行人过马路时，车行道持续亮绿灯让车通行，直到有行人按过街按钮，才执行人、车通行的切换。行人按下按钮后延时30秒，切换到人行道通行15秒，然后切换到车通行30秒。此后，若无人按过街按钮，则保持车通行状态，若继续有人按下过街按钮，则执行人、车分别15秒和30秒的轮换通行。车行道的绿灯到红灯的切换有3秒过渡时间（亮黄灯），人行道则只有红、绿灯，且无过渡时间。

（1） “红”、“绿”、“黄”灯的状态可组合为二进制表示，如红灯亮表示为：“0100”，黄灯亮：“0010”，绿灯亮：“0001”（十进制分别为“4”、“2”、“1”），可以用一个数码管显示。

（2）人行道和车行道的信号灯状态分别用一个数码管显示，计时则用另两个数码管显示。
