sampler g_Sampler0 : register(s13);
float4 g_TexelWeights0 : register(c184);
float4 g_TexelWeights1 : register(c185);
float2 g_TotalOffset : register(c186);
float4 g_offsetPow : register(c187);

struct PS_IN
{
	float4 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float4 texcoord3 : TEXCOORD3;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float4 r4;
	r0 = tex2D(g_Sampler0, i.texcoord.zwzw);
	r1 = g_TotalOffset.xyxy + i.texcoord3.zwxy;
	r2 = tex2D(g_Sampler0, r1.zwzw);
	r1 = tex2D(g_Sampler0, r1);
	r0.xy = r0.xw + r2.xw;
	r2 = tex2D(g_Sampler0, i.texcoord);
	r0.y = -r0.y + r2.w;
	r0.y = abs(r0.y) + -g_offsetPow.y;
	r0.y = (r0.y >= 0) ? 1 : 0;
	r0.x = r0.x * 0.5 + r0.y;
	r0.y = r1.x + r2.x;
	r0.y = r0.y * g_TexelWeights0.x;
	r0.x = dot(r0.x, g_TexelWeights0.y) + r0.y;
	r1 = tex2D(g_Sampler0, i.texcoord1);
	r3 = g_TotalOffset.xyxy + i.texcoord2.zwxy;
	r4 = tex2D(g_Sampler0, r3);
	r3 = tex2D(g_Sampler0, r3.zwzw);
	r0.yz = r1.xw + r4.xw;
	r0.z = r2.w + -r0.z;
	r0.z = abs(r0.z) + -g_offsetPow.y;
	r0.z = (r0.z >= 0) ? 1 : 0;
	r0.y = r0.y * 0.5 + r0.z;
	r0.x = dot(r0.y, g_TexelWeights0.z) + r0.x;
	r1 = tex2D(g_Sampler0, i.texcoord1.zwzw);
	r0.yz = r3.xw + r1.xw;
	r0.z = r2.w + -r0.z;
	r0.z = abs(r0.z) + -g_offsetPow.y;
	r0.z = (r0.z >= 0) ? 1 : 0;
	r0.y = r0.y * 0.5 + r0.z;
	r0.x = dot(r0.y, g_TexelWeights0.w) + r0.x;
	r1 = tex2D(g_Sampler0, i.texcoord2);
	r3 = g_TotalOffset.xyxy + i.texcoord1.zwxy;
	r4 = tex2D(g_Sampler0, r3);
	r3 = tex2D(g_Sampler0, r3.zwzw);
	r0.yz = r1.xw + r4.xw;
	r0.z = r2.w + -r0.z;
	r0.z = abs(r0.z) + -g_offsetPow.y;
	r0.z = (r0.z >= 0) ? 1 : 0;
	r0.y = r0.y * 0.5 + r0.z;
	r0.x = dot(r0.y, g_TexelWeights1.x) + r0.x;
	r1 = tex2D(g_Sampler0, i.texcoord2.zwzw);
	r0.yz = r3.xw + r1.xw;
	r0.z = r2.w + -r0.z;
	r0.z = abs(r0.z) + -g_offsetPow.y;
	r0.z = (r0.z >= 0) ? 1 : 0;
	r0.y = r0.y * 0.5 + r0.z;
	r0.x = dot(r0.y, g_TexelWeights1.y) + r0.x;
	r1 = tex2D(g_Sampler0, i.texcoord3);
	r3 = g_TotalOffset.xyxy + i.texcoord.zwxy;
	r4 = tex2D(g_Sampler0, r3);
	r3 = tex2D(g_Sampler0, r3.zwzw);
	r0.yz = r1.xw + r4.xw;
	r0.z = r2.w + -r0.z;
	r0.z = abs(r0.z) + -g_offsetPow.y;
	r0.z = (r0.z >= 0) ? 1 : 0;
	r0.y = r0.y * 0.5 + r0.z;
	r0.x = dot(r0.y, g_TexelWeights1.z) + r0.x;
	r1 = tex2D(g_Sampler0, i.texcoord3.zwzw);
	r0.yz = r3.xw + r1.xw;
	r0.z = r2.w + -r0.z;
	r0.z = abs(r0.z) + -g_offsetPow.y;
	r0.z = (r0.z >= 0) ? 1 : 0;
	r0.y = r0.y * 0.5 + r0.z;
	r0.x = dot(r0.y, g_TexelWeights1.w) + r0.x;
	o = max(g_offsetPow.w, r0.x);

	return o;
}
