#include <fstream>

using namespace std;

ofstream fout ("Level0.lv");

int main() {
	fout << "size " << 3000 << ' ' << 3000 << endl;
	fout << "wall " << 10 << ' ' << 3000 << ' ' << 0 << ' ' << 0 << endl;
	fout << "wall " << 10 << ' ' << 3000 << ' ' << 2990 << ' ' << 0 << endl;
	fout << "wall " << 3000 << ' ' << 10 << ' ' << 0 << ' ' << 2990 << endl;
	fout << "wall " << 3000 << ' ' << 10 << ' ' << 0 << ' ' << 0 << endl;
	fout << "unit " << 720 << ' ' << 100 << endl;
	fout << "camera " << 720 << ' ' << 450 << endl;
	for (int i = 1; i <= 12; ++i) {
		fout << "wall " << 150 << ' ' << 20 << ' ' << 80 * i + 150 * (i - 1) << ' ' << 120 * i << endl;
	}
	for (int i = 1; i <= 12; ++i) {
		fout << "wall " << 150 << ' ' << 20 << ' ' << 3000 - (80 * i + 150 * (i + 1)) << ' ' << 120 * (i + 12) << endl;
	}
	return 0;
}