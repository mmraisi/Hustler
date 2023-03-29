import SwiftUI
import URLImage
struct ProductItem : View {
    // the following is the custom list Item
    var  product : Product
    
    var body: some View {
        
        HStack {
            URLImage(URL(string: product.pImageURI)!) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 70, height: 70)
                    .cornerRadius(10)
            }
            VStack(alignment: .leading, spacing: 5) {
                Text(product.pName)
                    .font(.system(size: 14))
                    .fontWeight(.medium)
                    .foregroundColor(Color.orange)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Price: $\(String(format: "%.2f", product.pPrice))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 5)
        .frame(maxWidth: .infinity, alignment: .leading)
        
    }
}

