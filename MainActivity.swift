import java.util
import java.net
import android.app
import android.content
import android.os
import android.util
import android.view
import android.widget
import com.google.gson
import com.squareup.okhttp

public class MainActivity: Activity {
	private var mCount = 0
	private var mPlusButton: Button!
	private var mNumberText: TextView!

	public override func onCreate(savedInstanceState: Bundle!) {
		super.onCreate(savedInstanceState)
		ContentView = R.layout.main
		instantiateView()
		
		mPlusButton.OnClickListener = Button.OnClickListener(){
			self.mCount++
			self.mNumberText.setText(self.mCount.toString())
		}
		
		// verify
		self.verifySwift()
		self.verifyGson()
		self.verifyOkHttp()
	}
	
	private func instantiateView(){
		mNumberText = findViewById(R.id.text_number) as! TextView
		mPlusButton = findViewById(R.id.btn_plus) as! Button
	}
	
	// MARK: - Swift Basic
	enum ValueType{
		case ONE
		case TWO
		
		func string() -> String{
			switch self{
				case .ONE:
				return "1"
				case .TWO:
				return "2"
			}
		}
	}
		
	private func verifySwift(){
		// Hello World
		println("Hello World")
		
		// Variable and Constant
		var variable = 10
		variable = 1
		let const = "str"
		
		// Array
		var values: [Int] = []
		values.append(0)
		
		// Closure
		let double = {(value: Int) -> Int in
			return value * 2
		}
		println(double(10))
		
		// Enum
		let type = ValueType.ONE
		println(type.string())
	}
	
	// MARK: - Gson
	class Person{
		let name: String
		let age: Int
		
		init(name: String, age: Int){
			self.name = name
			self.age = age
		}
	}
		
	private func verifyGson(){
		let gson = Gson()

		let json = "{name: \"rebirth\", age: 21}"
		if let me = gson.fromJson(json, Person.Type) as? Person{
			println(me.name)
		}
		
		let person = Person("rebirth", age: 21)
		println(gson.toJson(person))
	}
	
	// MARK: - OkHttp
	class TestAsyncTask<String>: AsyncTask<Void, Void, String>{
		override func doInBackground(args: Void...) -> String{
			let request = Request.Builder()
				.url("http://httpbin.org/headers")
				.get()
				.build()
				
			let client = OkHttpClient()
			
			let response = client.newCall(request).execute()
			return response.body().string() as! String
		}
		
		override func onPostExecute(result: String){
			println(result)
		}
	}
	
	private func verifyOkHttp(){
		TestAsyncTask<String>().execute()
	}
}