sampler g_Sampler0 : register(s13);
sampler g_Sampler1 : register(s14);
sampler g_Sampler2 : register(s15);

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float2 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float4 texcoord3 : TEXCOORD3;
	float3 texcoord4 : TEXCOORD4;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	r0 = tex2D(g_Sampler0, i.texcoord);
	r1.x = r0.y + r0.x;
	r1.x = r0.z + r1.x;
	r1.x = r1.x * i.texcoord4.y;
	r1.y = r0.w * i.texcoord4.x;
	r1.x = r1.x * 0.33333334 + r1.y;
	r1.w = r0.w * i.texcoord4.z + r1.x;
	r0.xyz = r0.xyz * i.texcoord4.xxx + i.texcoord4.yyy;
	r1.xyz = r0.xyz + i.texcoord4.zzz;
	r0 = i.texcoord2;
	r0 = r1 * r0 + i.texcoord3;
	r1 = tex2D(g_Sampler1, i.texcoord1);
	r0.w = r0.w * r1.w;
	r1.xyz = r0.xyz * r0.www + -1;
	r0.xyz = r0.xyz * -r0.www + 1;
	r0.x = 1 / r0.x;
	r2 = tex2D(g_Sampler2, i.texcoord1);
	r0.x = r0.x * r2.x;
	o.x = (r1.x >= 0) ? 1 : r0.x;
	r0.x = 1 / r0.y;
	r0.y = 1 / r0.z;
	r0.xy = r0.xy * r2.yz;
	o.yz = (r1.yz >= 0) ? 1 : r0.xy;
	o.w = 1;

	return o;
}
