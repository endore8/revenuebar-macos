//
//  ProjectFetcher.swift
//  Revenue Bar
//
//  Created by Oleh on 01/09/2024.
//

import Foundation

enum ProjectFetcherError: Error {
    case noProjectFound
}

struct ProjectFetch {
    let project: Project
    let metrics: ProjectMetrics
}

protocol ProjectFetcherType {
    func fetch(key: String, completion: @escaping TypeResultClosure<ProjectFetch>)
}

struct ProjectFetcher: ProjectFetcherType {
    
    let session: URLSession
    
    // MARK: - ProjectFetcherType
    
    func fetch(key: String, completion: @escaping TypeResultClosure<ProjectFetch>) {
        self.fetchProject(key: key) { result in
            switch result {
            case .success(let project):
                self.fetchProjectMetrics(projectId: project.id, key: key) { result in
                    switch result {
                    case .success(let metrics):
                        let result = ProjectFetch(
                            project: project,
                            metrics: metrics
                        )
                        completion(.success(result))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Private
    
    private func fetchProject(key: String, completion: @escaping TypeResultClosure<Project>) {
        self.fetch(path: "projects", key: key) { result in
            switch result {
            case .success(let data):
                do {
                    let object = try RCProjects.with(jsonData: data)
                    guard 
                        let project = object.items.first
                    else {
                        completion(.failure(ProjectFetcherError.noProjectFound))
                        return
                    }
                    let result = Project(
                        id: project.id,
                        key: key,
                        name: project.name
                    )
                    completion(.success(result))
                }
                catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func fetchProjectMetrics(projectId: String, key: String, completion: @escaping TypeResultClosure<ProjectMetrics>) {
        self.fetch(path: "projects/\(projectId)/metrics/overview", key: key) { result in
            switch result {
            case .success(let data):
                do {
                    let object = try RCProjectMetricsOverview.with(jsonData: data)
                    let acceptableMetrics = ["active_trials", "active_subscriptions", "mrr", "revenue", "new_customers", "active_users", "num_tx_last_28_days"]
                    let metrics = object.metrics
                        .filter { metric in
                            acceptableMetrics.contains(metric.id)
                        }
                        .map { metric in
                            ProjectMetrics.Metric(
                                name: metric.name,
                                description: metric.description,
                                value: metric.value,
                                updatedAt: metric.lastUpdatedAt
                            )
                        }
                    let result = ProjectMetrics(
                        metrics: metrics
                    )
                    completion(.success(result))
                }
                catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func fetch(path: String, key: String, completion: @escaping TypeResultClosure<Data>) {
        let url = URL(string: "https://api.revenuecat.com/v2/")!.appending(path: path)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["Authorization": "Bearer \(key)"]
        let task = self.session.dataTask(with: request) { data, response, error in
            if let error {
                completion(.failure(error))
            } 
            else if let data {
                completion(.success(data))
            }
        }
        task.resume()
    }
}

private struct RCProjects: Codable {
    let items: [Project]
    
    struct Project: Codable {
        let id: String
        let name: String
    }
}

private struct RCProjectMetricsOverview: Codable {
    let metrics: [Metric]
    
    struct Metric: Codable {
        let id: String
        let name: String
        let description: String?
        let lastUpdatedAt: Date?
        let value: Int
    }
}
