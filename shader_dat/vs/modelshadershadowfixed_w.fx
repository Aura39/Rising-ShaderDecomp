float4x4 g_ShadowView : register(c32);
float4x4 g_ShadowViewProj : register(c28);
float4x4 g_World : register(c16);
float4x4 g_WorldView : register(c20);
float4x4 g_WorldViewProj : register(c24);

struct VS_IN
{
	float4 position : POSITION;
	float4 normal : NORMAL;
};

struct VS_OUT
{
	float4 position : POSITION;
	float4 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float4 texcoord3 : TEXCOORD3;
	float3 texcoord5 : TEXCOORD5;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	float4 r1;
	r0 = i.position.xyzx * float4(1, 1, 1, 0) + float4(0, 0, 0, 1);
	o.position.x = dot(r0, transpose(g_WorldViewProj)[0]);
	o.position.y = dot(r0, transpose(g_WorldViewProj)[1]);
	o.position.w = dot(r0, transpose(g_WorldViewProj)[3]);
	r1.w = dot(r0, transpose(g_World)[3]);
	r1.x = dot(r0, transpose(g_World)[0]);
	r1.y = dot(r0, transpose(g_World)[1]);
	r1.z = dot(r0, transpose(g_World)[2]);
	o.texcoord2.x = dot(r1, transpose(g_ShadowView)[0]);
	o.texcoord2.y = dot(r1, transpose(g_ShadowView)[1]);
	o.texcoord2.z = dot(r1, transpose(g_ShadowView)[2]);
	o.texcoord1.x = dot(r1, transpose(g_ShadowViewProj)[0]);
	o.texcoord1.y = dot(r1, transpose(g_ShadowViewProj)[1]);
	o.texcoord1.z = dot(r1, transpose(g_ShadowViewProj)[2]);
	o.texcoord1.w = dot(r1, transpose(g_ShadowViewProj)[3]);
	o.texcoord5 = r1.xyz;
	r1.x = dot(r0, transpose(g_WorldViewProj)[2]);
	o.texcoord3.w = dot(r0, transpose(g_WorldView)[2]);
	o.position.z = r1.x + -0.001;
	r0 = transpose(g_ShadowView)[0];
	r1.xyz = r0.yyy * transpose(g_World)[1].xyz;
	r1.xyz = transpose(g_World)[0].xyz * r0.xxx + r1.xyz;
	r0.xyz = transpose(g_World)[2].xyz * r0.zzz + r1.xyz;
	r0.xyz = transpose(g_World)[3].xyz * r0.www + r0.xyz;
	o.texcoord3.x = dot(i.normal.xyz, r0.xyz);
	r0 = transpose(g_ShadowView)[1];
	r1.xyz = r0.yyy * transpose(g_World)[1].xyz;
	r1.xyz = transpose(g_World)[0].xyz * r0.xxx + r1.xyz;
	r0.xyz = transpose(g_World)[2].xyz * r0.zzz + r1.xyz;
	r0.xyz = transpose(g_World)[3].xyz * r0.www + r0.xyz;
	o.texcoord3.y = dot(i.normal.xyz, r0.xyz);
	r0 = transpose(g_ShadowView)[2];
	r1.xyz = r0.yyy * transpose(g_World)[1].xyz;
	r1.xyz = transpose(g_World)[0].xyz * r0.xxx + r1.xyz;
	r0.xyz = transpose(g_World)[2].xyz * r0.zzz + r1.xyz;
	r0.xyz = transpose(g_World)[3].xyz * r0.www + r0.xyz;
	o.texcoord3.z = dot(i.normal.xyz, r0.xyz);
	o.texcoord2.w = 200;

	return o;
}
