import pandas as pd
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity
from sklearn.cluster import KMeans
from sklearn.metrics import silhouette_score
import matplotlib.pyplot as plt
import numpy as np
from collections import Counter

df = pd.read_excel("IT_Support_Ticket_Desk_English.xlsx")


# Combine Subject and Body for clustering
df["Combined_Text"] = df["Subject"].astype(str) + " " + df["Body"].astype(str)


# Vectorize using TF-IDF with improved parameters
vectorizer = TfidfVectorizer(
    stop_words='english',
    max_features=1000,  # Limit features for performance
    min_df=2,          # Ignore terms appearing in less than 2 documents
    max_df=0.8         # Ignore terms appearing in more than 80% of documents
)

X = vectorizer.fit_transform(df["Combined_Text"])


# Don't run it if you have found the optimal number for clustering 
# print("🔍 FINDING OPTIMAL NUMBER OF CLUSTERS")

# METHOD 1: Elbow Method - Find the "elbow" in the curve
def find_optimal_clusters_elbow(X, max_clusters=10):
    """Find optimal clusters using elbow method"""
    inertias = []
    silhouette_scores = []
    K_range = range(5, max_clusters)  # At least 10 tickets per cluster
    
    print("Testing different numbers of clusters...")
    for k in K_range:
        # Create KMeans model
        kmeans = KMeans(n_clusters=k, random_state=42, n_init=10)
        kmeans.fit(X)
        
        # Calculate metrics
        inertias.append(kmeans.inertia_)  # Within-cluster sum of squares
        silhouette_scores.append(silhouette_score(X, kmeans.labels_))
        
        print(f"k={k}: Inertia={kmeans.inertia_:.2f}, Silhouette={silhouette_score(X, kmeans.labels_):.3f}")
    
    # Find best silhouette score
    best_k = K_range[np.argmax(silhouette_scores)]
    best_silhouette = max(silhouette_scores)
    
    print(f"\n🎯 RECOMMENDED: {best_k} clusters (Silhouette Score: {best_silhouette:.3f})")
    
    return best_k, K_range, inertias, silhouette_scores

# Find optimal clusters
# optimal_k, k_range, inertias, silhouette_scores = find_optimal_clusters_elbow(X)


# 🎯 RECOMMENDED: 8 clusters (Silhouette Score: 0.037)
# Perform clustering with optimal number
kmeans = KMeans(n_clusters=8, random_state=42, n_init=10)
df["Cluster_ID"] = kmeans.fit_predict(X)



def generate_cluster_names(df, vectorizer, kmeans, top_n_words=4):
    """Generate meaningful names for clusters based on top terms"""
    
    feature_names = vectorizer.get_feature_names_out()
    cluster_names = {}
    
    print("Generating cluster names based on top terms...")
    
    for cluster_id in range(8):
        # Get cluster center (most important features for this cluster)
        cluster_center = kmeans.cluster_centers_[cluster_id]
        
        # Get top terms for this cluster
        top_indices = cluster_center.argsort()[-top_n_words:][::-1]
        top_terms = [feature_names[i] for i in top_indices]
        
        # Create a meaningful name
        cluster_name = "_".join(top_terms).replace(" ", "_")
        cluster_names[cluster_id] = cluster_name
        
        # Also get sample subjects for validation
        cluster_tickets = df[df['Cluster_ID'] == cluster_id]
        sample_subjects = cluster_tickets['Subject'].head(3).tolist()
        
        print(f"\nCluster {cluster_id}: '{cluster_name}'")
        print(f"  Top terms: {', '.join(top_terms)}")
        print(f"  Tickets in cluster: {len(cluster_tickets)}")
        print(f"  Sample subjects:")
        for subject in sample_subjects:
            print(f"    - {subject}")
    
    return cluster_names

# Generate cluster names
cluster_names = generate_cluster_names(df, vectorizer, kmeans)

# Add named clusters to dataframe
df['Cluster_Name'] = df['Cluster_ID'].map(cluster_names)
df['Cluster_Size'] = df['Cluster_ID'].map(df['Cluster_ID'].value_counts())



# *** Generating Similarity Score ***


# Clean missing values in Body/Answer
df["Body"] = df["Body"].fillna("").astype(str)
df["Answer"] = df["Answer"].fillna("").astype(str)

# Combine all text for vectorization
combined_texts = df["Body"].tolist() + df["Answer"].tolist()

# TF-IDF Vectorization
vectorizer = TfidfVectorizer(stop_words="english")
tfidf_matrix = vectorizer.fit_transform(combined_texts)


# Calculate cosine similarity for each Body-Answer pair
similarity_scores = []
for i in range(len(df)):
    score = cosine_similarity(tfidf_matrix[i], tfidf_matrix[i + len(df)])[0][0]
    similarity_scores.append(score)

# Add score to DataFrame
df["Similarity_Score"] = similarity_scores


# Adding Labels
df['Similarity_Level'] = pd.cut(
        df['Similarity_Score'],
        bins=[0, 0.3, 0.6, 1.0],
        labels=['Low', 'Medium', 'High'],
        include_lowest=True
    )


# Save results

df=df.drop( columns='Combined_Text' )
output_file = "tickets_with_named_clusters_similiarity_score.xlsx"
df.to_excel(output_file, index=False)