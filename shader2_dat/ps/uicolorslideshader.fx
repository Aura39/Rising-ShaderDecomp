sampler g_Sampler0 : register(s13);
sampler g_Sampler1 : register(s14);

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float2 texcoord1 : TEXCOORD1;
	float2 texcoord2 : TEXCOORD2;
	float2 texcoord3 : TEXCOORD3;
	float2 texcoord4 : TEXCOORD4;
	float4 texcoord5 : TEXCOORD5;
	float4 texcoord6 : TEXCOORD6;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	r0 = tex2D(g_Sampler0, i.texcoord1);
	r1 = i.texcoord5;
	r0.y = r0.w * r1.w + i.texcoord6.w;
	r0.x = r0.y * r0.x;
	r2 = tex2D(g_Sampler0, i.texcoord2);
	r2.x = r2.w * r1.w + i.texcoord6.w;
	r0.y = r2.x * r2.y;
	r2 = tex2D(g_Sampler0, i.texcoord3);
	r2.x = r2.w * r1.w + i.texcoord6.w;
	r0.z = r2.x * r2.z;
	r2 = tex2D(g_Sampler0, i.texcoord);
	r0.w = r2.w;
	r0 = r0 * r1 + i.texcoord6;
	r1 = tex2D(g_Sampler1, i.texcoord4);
	o.w = r0.w * r1.w;
	o.xyz = r0.xyz;

	return o;
}
