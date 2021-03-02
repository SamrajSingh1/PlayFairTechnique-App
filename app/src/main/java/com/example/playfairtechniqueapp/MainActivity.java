package com.example.playfairtechniqueapp;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import android.widget.*;
public class MainActivity extends AppCompatActivity {
   public static EditText e1,e2;
   public static TextView t1;
   Button b1,b2;
   public static PlayfairCipherDecryption en=new PlayfairCipherDecryption();
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        e1=findViewById(R.id.secretKey);
        e2=findViewById(R.id.msgContent);
        t1=findViewById(R.id.textView4);
        b1=findViewById(R.id.but1);
        b2=findViewById(R.id.but2);
        b1.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                encrpt();
            }
        });
        b2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                decrpt();
            }
        });
    }
   public static void encrpt(){
       String key=e1.getText().toString();
       String msg=e2.getText().toString();
        en.setKey(key);
        en.KeyGen();
        String enMsg=en.encryptMessage(msg);
        t1.setText(enMsg);
   }
    public static void decrpt(){
        String key=e1.getText().toString();
        String msg=e2.getText().toString();
        en.setKey(key);
        en.KeyGen();
        String deMsg=en.decryptMessage(msg);
        t1.setText(deMsg);
    }

}