# Topic 4: Virtual Private Clouds (VPCs)

<!-- TOC -->

- [Topic 4: Virtual Private Clouds (VPCs)](#topic-4-virtual-private-clouds-vpcs)
  - [Lesson 4.1: Creating Your Own VPC](#lesson-41-creating-your-own-vpc)
    - [Principle 4.1](#principle-41)
    - [Practice 4.1](#practice-41)
      - [Lab 4.1.1: New VPC with "Private" Subnet](#lab-411-new-vpc-with-private-subnet)
      - [Lab 4.1.2: Internet Gateway](#lab-412-internet-gateway)
      - [Lab 4.1.3: EC2 Key Pair](#lab-413-ec2-key-pair)
      - [Lab 4.1.4: Test Instance](#lab-414-test-instance)
        - [Question: Post Launch](#question-post-launch)
        - [Question: Verify Connectivity](#question-verify-connectivity)
      - [Lab 4.1.5: Security Group](#lab-415-security-group)
        - [Question: Connectivity](#question-connectivity)
      - [Lab 4.1.6: Elastic IP](#lab-416-elastic-ip)
        - [Question: Ping](#question-ping)
        - [Question: SSH](#question-ssh)
        - [Question: Traffic](#question-traffic)
      - [Lab 4.1.7: NAT Gateway](#lab-417-nat-gateway)
        - [Question: Access](#question-access)
        - [Question: Egress](#question-egress)
        - [Question: Deleting the Gateway](#question-deleting-the-gateway)
        - [Question: Recreating the Gateway](#question-recreating-the-gateway)
      - [Lab 4.1.8: Network ACL](#lab-418-network-acl)
        - [Question: EC2 Connection](#question-ec2-connection)
    - [Retrospective 4.1](#retrospective-41)
  - [Lesson 4.2: Integration with VPCs](#lesson-42-integration-with-vpcs)
    - [Principle 4.2](#principle-42)
    - [Practice 4.2](#practice-42)
      - [Lab 4.2.1: VPC Peering](#lab-421-vpc-peering)
      - [Lab 4.2.2: EC2 across VPCs](#lab-422-ec2-across-vpcs)
        - [Question: Public to Private](#question-public-to-private)
        - [Question: Private to Public](#question-private-to-public)
      - [Lab 4.2.3: VPC Endpoint Gateway to S3](#lab-423-vpc-endpoint-gateway-to-s3)
    - [Retrospective 4.2](#retrospective-42)
      - [Question: Corporate Networks](#question-corporate-networks)
  - [Further Reading](#further-reading)

<!-- /TOC -->

## Lesson 4.1: Creating Your Own VPC

### Principle 4.1

*VPCs provide isolated environments for running all of your AWS
services. Non-default VPCs are a critical component of any safe
architecture.*

### Practice 4.1

This section walks you through the steps to create a new VPC. On every
engagement, you'll be working in VPCs created by us or the client. Never
use EC2 Classic or the default VPC.

This is a complicated set of labs. If you get stuck, take a look at the
example template in the
[AWS::EC2::VPCPeering](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-vpcpeeringconnection.html)
doc. It gives you a lot of info, but you can use it to see how resources
are tied together. The AWS docs also provide a
[VPC template sample](https://s3.amazonaws.com/cloudformation-templates-us-east-1/vpc_single_instance_in_subnet.template)
that may be useful.

#### Lab 4.1.1: New VPC with "Private" Subnet

Launch a new VPC via your AWS account, specifying a region that will be
used throughout these lessons. Here most of the resources will be provisioned using Cloudformation.

- Use a [CloudFormation YAML template](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/template-reference.html).
In the AWS management console search for the CloudFormation service, open the service and click on create stack ( A stack is a collection of AWS resources that you can manage as a single unit. In other words, you can create, update, or delete a collection of resources by creating, updating, or deleting stacks. All the resources in a stack are defined by the stack's AWS CloudFormation template).
- Tag all your new resources with:

  - the key "user" and your AWS user name;
  - "stelligent-u-lesson" and this lesson number;
  - "stelligent-u-lab" and this lab number.

- Don't use dedicated tenancy (it's needlessly expensive)

![image](https://user-images.githubusercontent.com/103466963/168157049-e6d75e1c-4478-4c4c-94ae-1d3b12bca080.png)

When you first launch your cloudformation template, it takes you to create stack and you just click on create stack directly. in the above image there is one stack already created. when you click on create stack it provides you with two options, to either create a stack with new resources or with existing resources. in this case we will go with new resources since we are going to define all the resources we need. Once you click on create stack it takes you to the next step as seen on the image below

![image](https://user-images.githubusercontent.com/103466963/168163348-af0ae225-c67b-4dcc-b946-00d8ed0f97f5.png)

So we have 3 options, template is ready, use a sample template and create template in designer. so choose create template in designer since we are doing everything from scratch and click on create template in designer to go to the next step which is all about building the cloudformation template.  A template is a declaration of the AWS resources that make up a stack. The template is stored as a text file whose format complies with the JavaScript Object Notation (JSON) or YAML standard. These templates describe the resources that you want to provision in your AWS CloudFormation stack.

![image](https://user-images.githubusercontent.com/103466963/168163037-867b242d-ec66-44ab-af14-ac722e25ed61.png)
 
 As seen on the image above, base on the resource you want to provision, select the resource under resource types, select the resource by clicking and holding the seleceted resource then drag and drop on the right. Do not forget to change the language of the template to either yaml or json. in this case we will be using the yaml format.
 Next, we will add resources to our template. make sure indentation is correct in the code. Note: Every time you make any changes to the template in the designer, it will ask for a refresh. Click on the refresh icon to refresh the designer.

- Assign it a /16 CIDR block in [private IP space](https://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_Subnets.html#VPC_Sizing),
  and provide that block as a stack parameter in a [[separate parameters.json
  file]](https://aws.amazon.com/blogs/devops/passing-parameters-to-cloudformation-stacks-with-the-aws-cli-and-powershell).
  
  - Expand EC2 resource type and drag ‘VPC’ to designer and in the ‘Properties’ tab, edit the name of the resource to VPC by clicking on the small pen, give it a name. in this case we will simply rename to VPC as seen below

![image](https://user-images.githubusercontent.com/103466963/168169560-432ff9ac-84f1-4343-a086-45a3578efda5.png)

- It is stated above that we should create a vpc and assign it a /16CIDRBlock

![image](https://user-images.githubusercontent.com/103466963/168170669-674ae8c3-804c-49d4-82b1-6e6db95b337f.png)

Once you have defined the properties of your vpc, go ahead to click on the up arrow marked in blue to create the stack. There are two ways you can do this its either you save the template in your local directory or in an s3 bucket, if stored in s3 then you will need the URL of that bucket. The two ways will be dealt with, whichever one you choose will still produce the same output.
 
![image](https://user-images.githubusercontent.com/103466963/168304112-aaba26a0-4c80-42a3-bb7c-9089a96281f9.png)

 - Once you click on the up arrow, you should be able to notice that the template has been stored in s3 by default because it provides the buckets URL, you can open the s3 service to verify that. see image below
 
 ![image](https://user-images.githubusercontent.com/103466963/168173917-12f0387e-44a3-4498-ad03-a1adf6b87762.png)
 
 - Click on next and it will take you to the next step which is to input the stack name, call the stack 'myvpc' 

![image](https://user-images.githubusercontent.com/103466963/168306908-0b083b5c-9c98-4c3a-baa5-71d1e1bd1466.png)

Click on next and it will take you to the step to Configure Stack Options, this step we will leave everything at the default settings which means no changes will be made here.

![image](https://user-images.githubusercontent.com/103466963/168307401-de0ad94c-db6e-43f0-9f33-4cf98f585df0.png)

-Go ahead and Click next and this will take you to the review page of your vpc. this is simply a summary of the stack we want to create. Once you review and everything is okay, click on create stack and once the stack starts creating, you can see the status showing create in progress, give it a few minutes then hit the refresh button to see the final status of the stack if stack creation was succeesful. if all the resources were provisioned correctly, indentations correct, code format is correct then the stack creation will be successful ,if not the stack creation will be unsuccessful and a roll back of all resources will be initiated except otherwise

![image](https://user-images.githubusercontent.com/103466963/168310646-c592cc92-74d7-45a0-a535-d690688fea1e.png)

Once the vpc creation is successfuly, click on stacks and you will be able to see the 'myvpc' stack 

![image](https://user-images.githubusercontent.com/103466963/168312064-d7ed2df6-2103-4e64-9713-0d89162b35dc.png)
 
- Create an EC2 subnet resource within your CIDR block that has a /24
  netmask.
  
  We are going to create a subnet that will be able to host our EC2 instance. Here we will not create the stack afresh all we need to keep doing is to keep updating the stack from now hence forth unless stated otherwise. click on the circle close to my vpc, then click on update
  
![image](https://user-images.githubusercontent.com/103466963/168324298-12124ded-3574-403a-82a7-2af85e9280b2.png)
 
 - click on next and select edit in designer. here we are simply trying to edit our current template, also go ahead and click on view in designer, from there you will be able to edit the template.
 Your updated template should like the one below
 
 ![image](https://user-images.githubusercontent.com/103466963/168327145-5baffe72-cdd4-4418-8214-c59f43e0100b.png)

Once all the resources have beeb provisioned correctly, click on the up arrow to update the stack, just click on next without changing anything till you finally reach the step where you have to update the stack. Go ahead to update the stack, the stack status shows that update is in progress

![image](https://user-images.githubusercontent.com/103466963/168328792-755e4e8e-a14b-4a52-bbba-45b05f8cf6d1.png)

Wait for a while and the refresh this tab to see the new status, it should tell us the update is complete as shown below

![image](https://user-images.githubusercontent.com/103466963/168329477-28dd4291-a4fc-4126-93f0-42aec7a7a074.png)


![image](https://user-images.githubusercontent.com/103466963/168332081-212734ca-d4a4-4c7f-890d-89d3fa0c4bd9.png)


-Now that our update is complete lets go into the console and check if all the resources defined in our tenplate have been created. call your vpc testvpc by editing the small section marked in blue to rename your vpc

![Screenshot (101)](https://user-images.githubusercontent.com/103466963/168333604-6ff7bb64-ea0b-4f74-bdea-3e72160afd10.png)

from the above image we were able to succesfully add tags to our vpc by simply defining it in the template. ignore the other tags its for the project vpc, for our test vpc we have three tags assigned which are those underlined in blue. also go ahead to check the properties of the vpc to see if it matches what was declared in the template

- Provide the VPC ID and subnet ID as stack outputs.

****vpc-02350c66e3fabd6b4**

**subnet-088edde1e8c609300****


#### Lab 4.1.2: Internet Gateway

Update your template to allow traffic [to and from instances](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Internet_Gateway.html)
on your "private" subnet.

- Add an Internet gateway
  [resource](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-internetgateway.html).
  
  All we nee to do is keep updating the stack, here we will create an internet gateway then attach it to our vpc and subnet
  
  ![image](https://user-images.githubusercontent.com/103466963/168337404-e809c834-ed52-4df7-8aac-9f017d4b1ce7.png)
  update your template by simply adding the internet gate way as shown in the image above and click on the arrow up to update the stack, follow same procedure like we did previosly and update the stack. Each time the stack update is complete open the console, go to the vpc service and check if the internet gateway has been successfully created


- Attach the gateway to your VPC.

- Create a route table for the VPC, add the gateway to it, attach it
  to your subnet.

We can't call your subnet "private" any more. Now that it has an
Internet Gateway, it can get traffic directly from the public Internet.

#### Lab 4.1.3: EC2 Key Pair

[Create an EC2 key pair](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html#having-ec2-create-your-key-pair)
that you'll use to ssh to a test instance created in later labs. Use the
AWS CLI.

- Save the output as a .pem file in your project directory.

- Be sure to create it in the same region you'll be doing your labs.

#### Lab 4.1.4: Test Instance

Launch an EC2 instance into your VPC.

- Create another CFN template that specifies an EC2 instance.

- For the subnet and VPC, reference the outputs from your VPC stack.

- Use the latest Amazon Linux AMI.

- Create a new parameter file for this template. Include the EC2 AMI
  ID, a T2 instance type, and the name of your key pair.

- Provide the instance ID and private IP address as stack outputs.

- Use the same tags you put on your VPC.

##### Question: Post Launch

_After you launch your new stack, can you ssh to the instance?_

##### Question: Verify Connectivity

_Is there a way that you can verify Internet connectivity from the instance
without ssh'ing to it?_

#### Lab 4.1.5: Security Group

Add a security group to your EC2 stack:

- Allow ICMP (for ping) and ssh traffic into your instance.

##### Question: Connectivity

_Can you ssh to your instance yet?_

#### Lab 4.1.6: Elastic IP

Add an Elastic IP to your EC2 stack:

- Attach it to your EC2 resource.

- Provide the public IP as a stack output.

Your EC2 was already on a network with an IGW, and now we've fully
exposed it to the Internet by giving it a public IP address that's
reachable from anywhere outside your VPC.

##### Question: Ping

_Can you ping your instance now?_

##### Question: SSH

_Can you ssh into your instance now?_

##### Question: Traffic

_If you can ssh, can you send any traffic (e.g. curl) out to the Internet?_

At this point, you've made your public EC2 instance an [ssh bastion](https://docs.aws.amazon.com/quickstart/latest/linux-bastion/architecture.html).
We'll make use of that to explore your network below.

#### Lab 4.1.7: NAT Gateway

Update your VPC template/stack by adding a [NAT gateway](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-nat-gateway.html).

- Attach your NAT GW to the subnet you created earlier.

- Provision and attach a new Elastic IP for the NAT gateway.

We need a private instance to explore some of the concepts below. Let's
add a new subnet and put a new EC2 instance on it. Add them to your
existing instance stack.

- The new subnet must have a unique netblock.

- The NAT gateway should be the default route for the new subnet.

- Aside from the subnet association, configure this instance just like
  the first one.

- This instance will not have an Elastic IP.

##### Question: Access

_Can you find a way to ssh to this instance?_

##### Question: Egress

_If you can ssh to it, can you send traffic out?_

##### Question: Deleting the Gateway

_If you delete the NAT gateway, what happens to the ssh session on your private
instance?_

##### Question: Recreating the Gateway

_If you recreate the NAT gateway and detach the Elastic IP from the public EC2
instance, can you still reach the instance from the outside?_

Test it out with the AWS console.

#### Lab 4.1.8: Network ACL

Add Network ACLs to your VPC stack.

First, add one on the public subnet:

- It applies to all traffic (0.0.0.0/0).

- Only allows ssh traffic from your IP address.

- Allows egress traffic to anything.

##### Question: EC2 Connection

_Can you still reach your EC2 instances?_

Add another ACL to your private subnet:

- Only allow traffic from the public subnet.

- Allow only ssh, ping, and HTTP.

- Allow all ports for egress traffic, but restrict replies to the
  public subnet.

_Verify again that you can reach your instance._

### Retrospective 4.1

For more information, read the [AWS Documentation on VPC](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html)

## Lesson 4.2: Integration with VPCs

### Principle 4.2

*VPCs are most useful when connected to external resources: other VPCs,
other AWS services, and corporate networks.*

### Practice 4.2

VPCs provide important isolation for your resources. Often, though, they
need to be connected to other services to poke holes through those walls
of isolation.

#### Lab 4.2.1: VPC Peering

Copy the VPC template you created earlier and modify it to launch a
private VPC in another region.

- Add a new [CIDR block](https://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_Subnets.html#VPC_Sizing)
  for this VPC that doesn't overlap with the original one.

- Don't attach an Internet gateway or NAT gateway to the new VPC. The
  new VPC will be private-only.

- Update both VPC stacks to accept the netblock of the peering VPC as
  a parameter, so that you can...

- add network ACLs in each VPC that allow all traffic in from the
  other VPC, and allow all traffic out from the source VPC.

Create a separate stack that will create a
[peering](https://docs.aws.amazon.com/vpc/latest/peering/vpc-peering-basics.html)
link between the 2 VPCs.

- Create a [VPC Peering Connection](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-vpcpeeringconnection.html)
  from one to the other.

- Add a route in each VPC that sends traffic for the other VPC's CIDR
  to that VPC.

- The VPC IDs should be passed as stack parameters.

#### Lab 4.2.2: EC2 across VPCs

Create a new EC2 template similar to your original one, but without an
Elastic IP.

- Launch it in your new private VPC.

##### Question: Public to Private

_Can you ping this instance from the public instance you created earlier?_

##### Question: Private to Public

_Can you ping your public instance from this private instance? Which IPs are
reachable, the public instance's private IP or its public IP, or both?_

Use traceroute to see where traffic flows to both the public and private IPs.

#### Lab 4.2.3: VPC Endpoint Gateway to S3

VPC endpoints are something you'll see in practically all of our client
engagements. It's really useful to know about them, but we realize the
entire VPC topic is more time-consuming than most.

Create a [VPC endpoint](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-vpcendpoint.html)
connection from your private VPC to S3.

- Add the VPC endpoint gateway to your private VPC's CFN template.
  Pass the S3 bucket name as a parameter so it can be included in
  the policy.

- Rework your access controls a bit to accommodate using a VPC
  endpoint:

  - Change the egress NACL rules on the subnet where the endpoint is
    attached so that they allow all traffic (see "Network ACL rules" in
    [Troubleshoot Issues Connecting to S3 from VPC Endpoints](https://aws.amazon.com/premiumsupport/knowledge-center/connect-s3-vpc-endpoint/).

  - In the bucket's [policy document](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-endpoints-s3.html#vpc-endpoints-policies-s3),
    grant access from your VPC and endpoint.

  - In the endpoint policy, grant access to the bucket you created in the S3 lesson.

After you update the stack, make sure you can reach the bucket from the
instance in your private VPC.

_Note: Try this out, but don't get stalled out here.If you're not
making good progress after a few hours, even with the help of others,
document where you're at and what's not working for you, then move on.
Even though this is a valuable foundation, we have more important things for
you to learn._

### Retrospective 4.2

#### Question: Corporate Networks

_How would you integrate your VPC with a corporate network?_

## Further Reading

- [VPN](https://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/vpn-connections.html)
  connections provide a way to connect to customer-premise networks.

- [VPC Endpoints](https://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/vpc-endpoints.html)
  provide a way to connect VPC privately to many more Amazon
  services, protecting any of that service traffic from traversing
  the open Internet.

- [Amazon VPC-to-Amazon VPC Connectivity Options](https://docs.aws.amazon.com/aws-technical-content/latest/aws-vpc-connectivity-options/amazon-vpc-to-amazon-vpc-connectivity-options.html)
  describes many more options and design patterns for using VPCs.

- Jellili Adebello did a Sharing is Caring presentation about
  [Multiple VPC deployments with a pipeline](https://github.com/stelligent/multi-vpc-pipeline)
  on 2018-10-12.
