#include <bits/stdc++.h>

using namespace std;

vector<char> generate_hamming(string message) {
  int n = message.size(), p = 0, hammingLength, k = 0;
  int currentPower = 1;
  string str = message;

  while (currentPower < p + n + 1) // darowan check kora
  {
    p++;
    currentPower *= 2;
  } // 2^r >=m+r+1

  hammingLength = n + p;
  reverse(str.begin(), str.end());
  vector<char> ans(hammingLength + 1, '0');

  for (int i = 1; i <= hammingLength; i++) {
    if (i & (i - 1)) {
      ans[i] = str[k];
      k++;
    }
  }

  for (int i = 0; i <= p - 1; i++) {
    int XOR = 0, flag = 1, skipBit = (1 << i);

    for (int j = (1 << i); j <= hammingLength; j += skipBit) {
      if (!flag) {
        flag ^= 1;
        continue;
      }

      flag ^= 1;
      int l = j, limit = skipBit;

      while (limit > 0 && l <= hammingLength) {
        XOR ^= (ans[l] - '0');
        l++, limit--;
      }
    }

    if (XOR) ans[(1 << i)] = '1';
    else ans[(1 << i)] = '0';
  }

  return ans;
}

int main() {
  string message;
  vector<char> hammingCode;

  cin >> message;

  hammingCode = generate_hamming(message);

  cout << "Hamming Code is : ";
  for (int i = hammingCode.size() - 1; i >= 1; i--) cout << hammingCode[i];

  cout << "\n";
}