float4 g_CommonParam;
float4x4 g_Proj;
float4x4 g_View;
float4x4 g_World;
float4x4 g_WorldMatrix;

struct VS_IN
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
	float4 normal : NORMAL;
};

struct VS_OUT
{
	float4 position : POSITION;
	float2 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
	float3 texcoord2 : TEXCOORD2;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float4 r4;
	float4 r5;
	float4 r6;
	float4 r7;
	r0 = transpose(g_World)[1];
	r1 = r0 * transpose(g_WorldMatrix)[1].y;
	r2 = transpose(g_World)[0];
	r1 = r2 * transpose(g_WorldMatrix)[1].x + r1;
	r3 = transpose(g_World)[2];
	r1 = r3 * transpose(g_WorldMatrix)[1].z + r1;
	r4 = transpose(g_World)[3];
	r1 = r4 * transpose(g_WorldMatrix)[1].w + r1;
	r5 = r1 * transpose(g_View)[3].y;
	r6 = r0 * transpose(g_WorldMatrix)[0].y;
	r6 = r2 * transpose(g_WorldMatrix)[0].x + r6;
	r6 = r3 * transpose(g_WorldMatrix)[0].z + r6;
	r6 = r4 * transpose(g_WorldMatrix)[0].w + r6;
	r5 = r6 * transpose(g_View)[3].x + r5;
	r7 = r0 * transpose(g_WorldMatrix)[2].y;
	r7 = r2 * transpose(g_WorldMatrix)[2].x + r7;
	r7 = r3 * transpose(g_WorldMatrix)[2].z + r7;
	r7 = r4 * transpose(g_WorldMatrix)[2].w + r7;
	r5 = r7 * transpose(g_View)[3].z + r5;
	r0 = r0 * transpose(g_WorldMatrix)[3].y;
	r0 = r2 * transpose(g_WorldMatrix)[3].x + r0;
	r0 = r3 * transpose(g_WorldMatrix)[3].z + r0;
	r0 = r4 * transpose(g_WorldMatrix)[3].w + r0;
	r2 = r0 * transpose(g_View)[3].w + r5;
	r3 = i.position.xyzx * float4(1, 1, 1, 0) + float4(0, 0, 0, 1);
	r2.w = dot(r3, r2);
	r4 = r1 * transpose(g_View)[2].y;
	r4 = r6 * transpose(g_View)[2].x + r4;
	r4 = r7 * transpose(g_View)[2].z + r4;
	r4 = r0 * transpose(g_View)[2].w + r4;
	r4.w = dot(r3, r4);
	o.texcoord1.z = dot(i.normal.xyz, r4.xyz);
	r2.z = r4.w + g_CommonParam.x;
	o.texcoord2.z = r4.w;
	r4 = r1 * transpose(g_View)[0].y;
	r1 = r1 * transpose(g_View)[1].y;
	r1 = r6 * transpose(g_View)[1].x + r1;
	r4 = r6 * transpose(g_View)[0].x + r4;
	r4 = r7 * transpose(g_View)[0].z + r4;
	r1 = r7 * transpose(g_View)[1].z + r1;
	r1 = r0 * transpose(g_View)[1].w + r1;
	r0 = r0 * transpose(g_View)[0].w + r4;
	r2.x = dot(r3, r0);
	o.texcoord1.x = dot(i.normal.xyz, r0.xyz);
	r2.y = dot(r3, r1);
	o.texcoord1.y = dot(i.normal.xyz, r1.xyz);
	o.position.x = dot(r2, transpose(g_Proj)[0]);
	o.position.y = dot(r2, transpose(g_Proj)[1]);
	o.position.z = dot(r2, transpose(g_Proj)[2]);
	o.position.w = dot(r2, transpose(g_Proj)[3]);
	o.texcoord2.xy = r2.xy;
	o.texcoord = i.texcoord.xy;

	return o;
}
