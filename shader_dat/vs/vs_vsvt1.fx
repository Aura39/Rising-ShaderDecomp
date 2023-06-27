float4 fogParam;
float4x4 g_Proj;
float4x4 g_ShadowView;
float4x4 g_ViewProjection;
float4x4 g_WorldMatrix;
float4x4 g_WorldView;

struct VS_IN
{
	float4 position : POSITION;
	float4 color : COLOR;
	float4 normal : NORMAL;
	float4 tangent : TANGENT;
	float4 texcoord : TEXCOORD;
};

struct VS_OUT
{
	float4 position : POSITION;
	float4 color : COLOR;
	float4 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float3 texcoord3 : TEXCOORD3;
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
	r0 = i.tangent * 2 + -1;
	r0.xyz = r0.www * r0.xyz;
	r1.x = dot(r0.xyz, transpose(g_WorldView)[0].xyz);
	r1.y = dot(r0.xyz, transpose(g_WorldView)[1].xyz);
	r1.z = dot(r0.xyz, transpose(g_WorldView)[2].xyz);
	r0.x = dot(r1.xyz, r1.xyz);
	r0.x = 1 / sqrt(r0.x);
	o.texcoord2.xyz = r0.xxx * r1.xyz;
	o.color = i.color;
	o.texcoord = i.texcoord.xyxy;
	o.texcoord2.w = i.tangent.w * 2 + -1;

	return o;
}
