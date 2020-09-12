class RnnSentences{
  int _current = 0;
  final now = DateTime.now();

  List<String> _sentences = [
    "ところで、今回使用したRNNですが、一体どのような状況の時に使うのでしょうか。",
    "例えば、今日の1BTCの価格が100万円ピッタリだったとします。この場合、明日の1BTCの価格はいくらになるでしょうか?",
    "ここで自信を持って答えられる人は普通いません。それは今日の価格しか分からないからです。",
    "一方、2日前は1BTC=96万円、1日前が1BTC=98万円,今日が1BTC=100万円だったとします。",
    "この場合は先ほどよりもずっと予想がしやすいですね。なぜなら価格が連続して上がっているということが分かったからです。",
    "RNNでは、このように、連続した値から次の値を導き出す際に非常に役に立ち、音声認識、自動翻訳などで特に活躍しています。",
    "なお、RNNの他にはANNやCNNなどがありますが、それらについてはアップデートで順次追加していこうと思います。",
    "最後に、今回の予測で使用したプログラムのソースコードをWeb上に公開しました。",
    "使用したプログラミング言語はPythonで、PyTorchというフレームワークを利用しています。",
    "気になる方は是非チェックしてみてください^^",
  ];


  String getSentence(){
    return _sentences[_current];
  }

  int increment(){
    _current ++;
    return _current;
  }

  int getCurrent(){
    return _current;
  }

  int getSentenceLength(){
    return _sentences.length;
  }

  int decrement(){
    _current --;
    return _current;
  }

  int setCurrent(int n){
    _current = n;
    return _current;
  }

  String getExactSentence(n){
    return _sentences[n];
  }

}