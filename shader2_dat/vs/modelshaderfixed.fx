float4x4 g_Proj : register(c4);
float4x4 g_World : register(c16);
float4x4 g_WorldView : register(c20);
float4x4 g_WorldViewProj : register(c24);

struct VS_IN
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
	float4 color : COLOR;
	float4 normal : NORMAL;
	float4 tangent : TANGENT;
};

struct VS_OUT
{
	float4 position : POSITION;
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float4 texcoord3 : TEXCOORD3;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	float4 r1;
	r0 = i.position.xyzx * float4(1, 1, 1, 0) + float4(0, 0, 0, 1);
	r1.x = dot(r0, transpose(g_WorldView)[0]);
	r1.y = dot(r0, transpose(g_WorldView)[1]);
	r1.z = dot(r0, transpose(g_WorldView)[2]);
	r1.w = dot(r0, transpose(g_WorldView)[3]);
	o.position.x = dot(r1, transpose(g_Proj)[0]);
	o.position.y = dot(r1, transpose(g_Proj)[1]);
	o.position.z = dot(r1, transpose(g_Proj)[2]);
	o.position.w = dot(r1, transpose(g_Proj)[3]);
	r0.x = dot(i.normal.xyz, transpose(g_World)[0].xyz);
	r0.y = dot(i.normal.xyz, transpose(g_World)[1].xyz);
	r0.z = dot(i.normal.xyz, transpose(g_World)[2].xyz);
	r0.w = dot(r0.xyz, r0.xyz);
	r0.w = 1 / sqrt(r0.w);
	o.texcoord2.xyz = r0.www * r0.xyz;
	r0.z = 1E-10;
	o.texcoord1.x = transpose(g_WorldViewProj)[0].x * r0.z + i.color.x;
	r0 = i.tangent * 2 + -1;
	r0.xyz = r0.www * r0.xyz;
	o.texcoord3.x = dot(r0.xyz, transpose(g_World)[0].xyz);
	o.texcoord3.y = dot(r0.xyz, transpose(g_World)[1].xyz);
	o.texcoord3.z = dot(r0.xyz, transpose(g_World)[2].xyz);
	o.texcoord = i.texcoord.xy;
	o.texcoord1.yzw = i.color.yzy * 1 + float3(1, 0, 0);
	o.texcoord2.w = 1;
	o.texcoord3.w = 1;

	return o;
}
