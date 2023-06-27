float4 fogParam;
float4x4 g_Proj;
float4x4 g_ShadowView;
float4x4 g_ViewInverseMatrix;
float4x4 g_ViewProjection;
float4x4 g_WorldMatrix;
float4x4 g_WorldView;

struct VS_IN
{
	float4 position : POSITION;
	float4 normal : NORMAL;
	float4 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
};

struct VS_OUT
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float3 texcoord3 : TEXCOORD3;
	float3 texcoord4 : TEXCOORD4;
	float4 texcoord7 : TEXCOORD7;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	float4 r1;
	r0 = i.position.xyzx * float4(1, 1, 1, 0) + float4(0, 0, 0, 1);
	r1.x = dot(r0, transpose(g_WorldMatrix)[0]);
	r1.y = dot(r0, transpose(g_WorldMatrix)[1]);
	r1.z = dot(r0, transpose(g_WorldMatrix)[2]);
	r1.w = dot(r0, transpose(g_WorldMatrix)[3]);
	o.texcoord7.x = dot(r1, transpose(g_ViewProjection)[0]);
	o.texcoord7.y = dot(r1, transpose(g_ViewProjection)[1]);
	o.texcoord7.w = dot(r1, transpose(g_ViewProjection)[3]);
	r1.x = dot(r1, transpose(g_ShadowView)[2]);
	o.texcoord7.z = abs(r1.x) * 0.005;
	r1.w = dot(r0, transpose(g_WorldView)[3]);
	r1.x = dot(r0, transpose(g_WorldView)[0]);
	r1.y = dot(r0, transpose(g_WorldView)[1]);
	r1.z = dot(r0, transpose(g_WorldView)[2]);
	o.position.x = dot(r1, transpose(g_Proj)[0]);
	o.position.y = dot(r1, transpose(g_Proj)[1]);
	o.position.z = dot(r1, transpose(g_Proj)[2]);
	o.position.w = dot(r1, transpose(g_Proj)[3]);
	o.texcoord1.xyz = r1.xyz;
	r0.x = r1.z + fogParam.y;
	o.texcoord1.w = r0.x * fogParam.x;
	r0.x = dot(i.normal.xyz, transpose(g_WorldView)[0].xyz);
	r0.y = dot(i.normal.xyz, transpose(g_WorldView)[1].xyz);
	r0.z = dot(i.normal.xyz, transpose(g_WorldView)[2].xyz);
	r0.w = dot(r0.xyz, r0.xyz);
	r0.w = 1 / sqrt(r0.w);
	o.texcoord3 = r0.www * r0.xyz;
	o.texcoord.xy = i.texcoord.xy;
	o.texcoord.zw = i.texcoord1.xy;
	r0.x = dot(i.position, transpose(g_WorldMatrix)[0]);
	r0.y = dot(i.position, transpose(g_WorldMatrix)[1]);
	r0.z = dot(i.position, transpose(g_WorldMatrix)[2]);
	r1.x = -transpose(g_ViewInverseMatrix)[0].w;
	r1.y = -transpose(g_ViewInverseMatrix)[1].w;
	r1.z = -transpose(g_ViewInverseMatrix)[2].w;
	r0.xyz = r0.xyz + r1.xyz;
	r1.w = dot(i.normal.xyz, transpose(g_WorldMatrix)[3].xyz);
	r1.x = dot(i.normal.xyz, transpose(g_WorldMatrix)[0].xyz);
	r1.y = dot(i.normal.xyz, transpose(g_WorldMatrix)[1].xyz);
	r1.z = dot(i.normal.xyz, transpose(g_WorldMatrix)[2].xyz);
	r0.w = dot(r1, r1);
	r0.w = 1 / sqrt(r0.w);
	r1.xyz = r0.www * r1.xyz;
	r0.w = dot(r0.xyz, r1.xyz);
	r0.w = r0.w + r0.w;
	r0.xyz = r1.xyz * -r0.www + r0.xyz;
	r0.w = -r0.z;
	o.texcoord4 = r0.xyw;

	return o;
}
