float4x4 Rmodelview;
float4 g_CameraParam;
float4x4 g_ShadowView;
float4x4 g_ViewProjection;
float4x4 proj;
float4x4 viewInverseMatrix;
float4x4 worldMatrix;

struct VS_IN
{
	float4 position : POSITION;
	float4 color : COLOR;
	float4 normal : NORMAL;
	float4 tangent : TANGENT;
	float4 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
};

struct VS_OUT
{
	float4 position : POSITION;
	float4 color : COLOR;
	float4 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float3 texcoord3 : TEXCOORD3;
	float3 texcoord4 : TEXCOORD4;
	float3 texcoord5 : TEXCOORD5;
	float3 texcoord6 : TEXCOORD6;
	float4 texcoord7 : TEXCOORD7;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r1;
	float4 r0;
	float4 r2;
	r1 = i.position.xyzx * float4(1, 1, 1, 0) + float4(0, 0, 0, 1);
	r0.x = dot(r1, transpose(worldMatrix)[0]);
	r0.y = dot(r1, transpose(worldMatrix)[1]);
	r0.z = dot(r1, transpose(worldMatrix)[2]);
	r0.w = dot(r1, transpose(worldMatrix)[3]);
	o.texcoord7.x = dot(r0, transpose(g_ViewProjection)[0]);
	o.texcoord7.y = dot(r0, transpose(g_ViewProjection)[1]);
	o.texcoord7.w = dot(r0, transpose(g_ViewProjection)[3]);
	r2.w = dot(r0, transpose(g_ShadowView)[2]);
	r0.w = dot(r1, transpose(Rmodelview)[3]);
	r0.x = dot(r1, transpose(Rmodelview)[0]);
	r0.y = dot(r1, transpose(Rmodelview)[1]);
	r0.z = dot(r1, transpose(Rmodelview)[2]);
	o.texcoord7.z = abs(r2.w) * 0.005;
	o.position.x = dot(r0, transpose(proj)[0]);
	o.position.y = dot(r0, transpose(proj)[1]);
	o.position.z = dot(r0, transpose(proj)[2]);
	o.position.w = dot(r0, transpose(proj)[3]);
	o.texcoord1.xyz = r0.xyz;
	r0.w = -r0.z + -g_CameraParam.x;
	r0.z = 1 / g_CameraParam.y;
	o.texcoord1.w = r0.w * r0.z;
	o.texcoord3.x = dot(i.normal.xyz, transpose(Rmodelview)[0].xyz);
	o.texcoord3.y = dot(i.normal.xyz, transpose(Rmodelview)[1].xyz);
	r0 = 2 * i.tangent + -1;
	o.texcoord3.z = dot(i.normal.xyz, transpose(Rmodelview)[2].xyz);
	r0.xyz = r0.www * r0.xyz;
	o.texcoord2.x = dot(r0.xyz, transpose(Rmodelview)[0].xyz);
	o.texcoord2.y = dot(r0.xyz, transpose(Rmodelview)[1].xyz);
	r1.x = dot(i.position, transpose(worldMatrix)[0]);
	r1.y = dot(i.position, transpose(worldMatrix)[1]);
	r1.z = dot(i.position, transpose(worldMatrix)[2]);
	r2.x = transpose(viewInverseMatrix)[0].w;
	r2.y = transpose(viewInverseMatrix)[1].w;
	r2.z = transpose(viewInverseMatrix)[2].w;
	o.texcoord2.z = dot(r0.xyz, transpose(Rmodelview)[2].xyz);
	o.texcoord6 = r1.xyz + -r2.xyz;
	r1.w = dot(r0.xyz, transpose(worldMatrix)[3].xyz);
	r1.x = dot(r0.xyz, transpose(worldMatrix)[0].xyz);
	r1.y = dot(r0.xyz, transpose(worldMatrix)[1].xyz);
	r1.z = dot(r0.xyz, transpose(worldMatrix)[2].xyz);
	r0.w = dot(i.normal.xyz, transpose(worldMatrix)[3].xyz);
	r0.x = dot(i.normal.xyz, transpose(worldMatrix)[0].xyz);
	r0.y = dot(i.normal.xyz, transpose(worldMatrix)[1].xyz);
	r0.z = dot(i.normal.xyz, transpose(worldMatrix)[2].xyz);
	r1.w = dot(r1, r1);
	r0.w = dot(r0, r0);
	r1.w = 1 / sqrt(r1.w);
	r0.w = 1 / sqrt(r0.w);
	o.texcoord4 = r1.xyz * r1.www;
	o.texcoord5 = r0.xyz * r0.www;
	o.color = i.color;
	o.texcoord.xy = i.texcoord.xy;
	o.texcoord.zw = i.texcoord1.xy;
	o.texcoord2.w = i.tangent.w * 2 + -1;

	return o;
}
