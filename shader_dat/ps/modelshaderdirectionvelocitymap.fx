sampler g_Sampler0 : register(s0);
float4 g_VecRate : register(c184);
float g_maskEnd : register(c186);
float g_maskStart : register(c185);

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	r0.xy = -0.5 + texcoord.xy;
	r0.z = dot(r0.z, r0.z) + 0;
	r0.xy = r0.xy * g_VecRate.zz;
	r0.z = 1 / sqrt(r0.z);
	r0.z = 1 / r0.z;
	r0.w = r0.z + -g_maskStart.x;
	r0.z = -r0.z + g_maskEnd.x;
	r0.w = (r0.w >= 0) ? 1 : 0;
	r0.xy = r0.ww * r0.xy;
	r1.x = g_maskEnd.x;
	r0.w = r1.x + -g_maskStart.x;
	r0.w = 1 / r0.w;
	r0.z = r0.w * r0.z;
	r0.z = -r0.z + 1;
	r1 = tex2D(g_Sampler0, texcoord);
	r1.xy = r1.xy + g_VecRate.xy;
	o.zw = r1.zw;
	o.xy = r0.xy * r0.zz + r1.xy;

	return o;
}
