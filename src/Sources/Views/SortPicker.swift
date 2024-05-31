import SwiftUI

struct SortPickerView: View {
    
    @ObservedObject var contactVM : ContactViewModel
    
    var body: some View {
        Picker("", selection: $contactVM.sortType) {
            ForEach(SortType.allCases){
                Text($0.rawValue.capitalized)
                    .tag($0)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }
}

struct SortPickerView_Previews: PreviewProvider {
    static var previews: some View {
        SortPickerView(contactVM: ContactViewModel())
    }
}
