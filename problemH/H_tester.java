import java.security.*;
import java.math.*;
import java.io.*;
import java.util.*;

public class H_tester {
    public static void main(String args[]) throws Exception{
		if(args.length != 3){
			System.out.println("Usage for XOR-HASH: x [file name] [TIS]");
			System.out.println("Usage for ADD-HASH: a [file name] [TIS]");
			return;
		}
		try{
			Scanner scan = new Scanner(new BufferedReader(new FileReader(args[1])));
			int block, pos;
			block = 0; pos = 0;
			byte data[] = new byte[500];
			MessageDigest m=MessageDigest.getInstance("MD5");
			BigInteger sum = new BigInteger("0");
			BigInteger mod = new BigInteger("2");
			mod = mod.pow(128);
			while(scan.hasNextByte(16)){
				data[pos]=scan.nextByte(16);
				pos++;
				if(pos==256){
					pos=0;
					block++;
					m.update(data, 0, 256);
					BigInteger val = new BigInteger(1,m.digest());
					if(args[0].compareTo("a")==0){
						sum = sum.add(val);
						sum = sum.mod(mod);
					}
					else
						sum = sum.xor(val);
						
				}
			}
			if(pos!=0){ System.out.println("Size of the last block is not 256"); return; }
			if(args[0].compareTo("a")==0){ if(block!=128) { System.out.println("Bad block count\n"); return; }}
			else if(block!=256) { System.out.println("Bad block count\n"); return; }	
			System.out.println("Hash: "+sum.toString(16));
			if(sum.toString(16).compareTo(args[2])!=0)
				System.out.println("Wrong answer");
			else
				System.out.println("Correct");
		}
		catch (Exception e){
			System.err.println("File input error");
		}
    }
}
