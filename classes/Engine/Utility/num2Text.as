package classes.Engine.Utility 
{
	/**
	 * ...
	 * @author Gedan
	 */
	public function num2Text(number:*, asPosition:Boolean = false):String
	{
		if (!(number is Number || number is int || number is uint)) throw new Error("num2Text called with an invalid number type!");
		
		var words:Array;
		
		if (asPosition == false) words = numWords;
		else words = numWordsPosition;
		
		if (number > 10 || isNaN(number))
		{
			return String(number);
		}
		else
		{
			return words[number];
		}
		
	}
	
	// ^ Packages can only have one externally public definition
	
	// \/ but we can have as many private/package-internal-only definitions as we want to make that happen
	private static const numWords:Array = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten"];
	private static const numWordsPosition:Array = ["zero", "first", "second", "third", "fourth", "fifth", "sixth", "seventh", "eighth", "ninth", "tenth"];
	
}