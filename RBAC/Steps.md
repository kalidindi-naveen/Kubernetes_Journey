### RBAC

#### Step1: Team Leader
```
Team Leader will send an email to create namespace, provide access to different employees with their permissions
```
```
EKS
––––
1. Create EKS Cluster (name: expense)

2. Onboard → 2 users
	harish → Trainee → Read Only
	suresh → Senior Engineer → Perform Deployments

3. Create Custom Policy (Readonly)

→ Click on Create Policy
→ Select Service as EKS
→ Provide Permission ⇒ DescribeCluster
→ Select Add ARN (because we are providing access to specific cluster)
→ Click on Add ARN
→ click on next

→ Give name: ExpenseEKSReadOnly → create Policy

4. Create IAM User harish ⇒ Attach ExpenseEKSReadOnly ⇒ create user

5. Create rbac.yaml 
https://github.com/kalidindi-naveen/Bin/blob/main/role1.yaml

6. Create aws-auth.yaml
→ Enable IAM Role to access EKS Cluster ?? ⇒ IAM user to access Cluster
https://docs.aws.amazon.com/eks/latest/userguide/auth-configmap.html
https://github.com/kalidindi-naveen/Bin/blob/main/aws-auth1.yaml

→ get configmap
kubectl get configmap aws-auth -n kube-system
NAME       DATA   AGE
aws-auth   1      51m
→ copy configmap to aws-auth.yaml
kubectl get configmap aws-auth -n kube-system -o yaml
→ Add mapUsers to aws-auth.yaml from above link

7. Create Ec2-Instance
	Login as ec2-user
	aws configure // Give harish credentials
	aws sts get-caller-identity

8. Given Cluster Describe Access to Harish (now he can get kubeconfig file)
→ aws eks update-kubeconfig --region us-east-1 --name expense
[ec2-user@ip-172-31-33-24 ~]$ aws eks update-kubeconfig --region us-east-1 --name expense
Added new context arn:aws:eks:us-east-1:381492110526:cluster/expense to /home/ec2-user/.kube/config

9. Install Kubectl in EC2
kubectl get nodes  // Authorization Failed 
kubectl  get pods -n expense // we can see pods

Flow:
———
→ Harish has access to EKSDescribeCluster or not
→ Get aws-auth configmap
→ user harish authenticated
→ check role and role bindings
```